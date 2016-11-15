// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:logging/logging.dart' as logging;

import '../../metadata.dart';
import '../../metadata_builder.dart';
import 'annotation.dart';
import 'comments.dart';
import 'constant_object.dart';
import 'class_metadata.dart';
import 'deprecation_annotation.dart';
import 'field_metadata.dart';
import 'function_metadata.dart';
import 'override_annotation.dart';
import 'protected_annotation.dart';
import 'union_type_annotation.dart';
import 'uri_referenced_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final logging.Logger _logger =
    new logging.Logger('dogma_source_analyzer.src.analyzer.library');

/// A function that determines if the library [element] should be loaded by the
/// analyzer and searched for metadata.
typedef bool ShouldLoadLibrary(LibraryElement element);

/// A function that transforms [input] [Uri] values.
///
/// The function can be used to convert different [Uri] schemes when analyzing
/// library elements.
typedef Uri UriTransform(Uri input);

/// Loads the library at the given [path] into the analysis [context] and
/// begins processing it for metadata.
///
/// If a library cannot be found at the given [path] then the function will
/// return `null`.
LibraryMetadata libraryMetadata(Uri path,
                                AnalysisContext context,
                               {List<AnalyzeAnnotation> annotationCreators,
                                ShouldLoadLibrary shouldLoad}) {
  // Create the source from a URI
  //
  // This handles source based and package based URIs.
  final source = context.sourceFactory.forUri2(path);

  // Get the kind of source being analyzed
  final kindOf = context.computeKindOf(source);

  if (kindOf == SourceKind.HTML) {
    throw new ArgumentError.value(path, 'path', 'Points to a HTML file and cannot be processed');
  } else if (kindOf == SourceKind.PART) {
    throw new ArgumentError.value(path, 'path', 'Points to a library part and not the library');
  } else if (kindOf == SourceKind.UNKNOWN) {
    _logger.warning('Source kind is unknown. Assuming optional library directive not present');
  }

  return libraryMetadataFromElement(
      context.computeLibraryElement(source),
      annotationCreators: annotationCreators,
      shouldLoad: shouldLoad
  );
}

/// Creates metadata from the library [element].
///
/// Annotations can be instantiated by specifying the [annotationCreators].
///
/// The [shouldLoad] function can be used to limit which libraries have
/// metadata generated for them.
LibraryMetadata libraryMetadataFromElement(LibraryElement element,
                                          {List<AnalyzeAnnotation> annotationCreators,
                                           ShouldLoadLibrary shouldLoad,
                                           UriTransform uriTransform}) {
  // Sanity check that the library element is present
  if (element == null) {
    _logger.severe('Metadata cannot be created from null library element', element);
    throw new ArgumentError.notNull('element');
  }

  annotationCreators ??= <AnalyzeAnnotation>[];
  _addDefaultAnnotationGenerators(annotationCreators);

  uriTransform ??= _uriNotChanged;

  final cached = <String, LibraryMetadata>{};

  if (shouldLoad == null) {
    final uri = element.source.uri;

    shouldLoad = uri.scheme == 'file'
        ? _checkFilePath
        : _checkPackagePath(uri.pathSegments[0]);
  }

  return _libraryMetadata(
      element,
      cached,
      shouldLoad,
      annotationCreators,
      uriTransform
  );
}

/// Creates a function that checks the [libraryName] to determine if the
/// referenced library should be loaded.
ShouldLoadLibrary _checkPackagePath(String libraryName) =>
    (element) {
      final uri = element.source.uri;

      if (uri.scheme == 'package') {
        return uri.pathSegments[0] == libraryName;
      } else {
        return false;
      }
    };

/// A function that just verifies that a file URI is being used by the
/// [element].
bool _checkFilePath(LibraryElement element) =>
    element.source.uri.scheme == 'file';

/// Searches the library [element] for metadata.
///
/// If no metadata is found within the library that is applicable then the
/// function will return `null`.
LibraryMetadata _libraryMetadata(LibraryElement element,
                                 Map<String, LibraryMetadata> cached,
                                 ShouldLoadLibrary shouldLoad,
                                 List<AnalyzeAnnotation> annotationCreators,
                                 UriTransform uriTransform) {
  // Use the URI
  final uri = uriTransform(element.source.uri);
  final uriString = uri.toString();

  // See if the library is in the cache
  if (cached.containsKey(uriString)) {
    return cached[uriString];
  }

  // Create the builder and get the import and export directives
  final builder = new LibraryMetadataBuilder()
      ..uri = uri
      ..name = element.name
      ..annotations = createAnnotations(element, annotationCreators)
      ..comments = elementComments(element)
      ..imports = uriReferenceList(element.imports)
      ..exports = uriReferenceList(element.exports);

  for (var unit in element.units) {
    // Add class metadata
    for (var type in unit.types) {
      builder.classes.add(classMetadata(type, annotationCreators));
    }

    // Add enum metadata
    for (var type in unit.enums) {
      builder.enums.add(classMetadata(type, annotationCreators));
    }

    // Add function metadata
    for (var function in unit.functions) {
      builder.functions.add(functionMetadata(function, annotationCreators));
    }

    // Add field metadata
    for (var field in unit.topLevelVariables) {
      builder.fields.add(fieldMetadata(field, annotationCreators));
    }

    // Add typedef metadata
    for (var typedef in unit.functionTypeAliases) {
      print(typedef.name);
    }
  }

  // Create the metadata
  final metadata = builder.build();

  // Add to the cache
  cached[uriString] = metadata;

  // Load the referenced libraries
  //
  // This is done after adding to the cache to prevent circular references
  // from causing a stack overflow

  // Get the imported libraries
  final imports = metadata.imports.toList();
  final exports = metadata.exports.toList();
  final importCount = imports.length;
  assert(importCount == element.imports.length);

  for (var i = 0; i < importCount; ++i) {
    final importedLibrary = element.imports[i].importedLibrary;

    imports[i].library = shouldLoad(importedLibrary)
        ? _libraryMetadata(importedLibrary, cached, shouldLoad, annotationCreators, uriTransform)
        : new LibraryMetadata(uriTransform(importedLibrary.source.uri));
  }

  final exportCount = exports.length;
  assert(exportCount == element.exports.length);

  for (var i = 0; i < exportCount; ++i) {
    final exportedLibrary = element.exports[i].exportedLibrary;

    exports[i].library = shouldLoad(exportedLibrary)
        ? _libraryMetadata(exportedLibrary, cached, shouldLoad, annotationCreators, uriTransform)
        : new LibraryMetadata(uriTransform(exportedLibrary.source.uri));
  }

  // Return the metadata
  return metadata;
}

/// Add default annotation generators.
///
/// The following will be added to the [annotationGenerators] list.
/// * analyzeDeprecatedAnnotation
/// * analyzeOverrideAnnotation
/// * analyzeProtectedAnnotation
/// * analyzeTypeUnionAnnotation
///
/// These are added as the values are not exposed to the client.
void _addDefaultAnnotationGenerators(List<AnalyzeAnnotation> annotationGenerators) {
  annotationGenerators
      ..add(analyzeDeprecatedAnnotation)
      ..add(analyzeOverrideAnnotation)
      ..add(analyzeProtectedAnnotation)
      ..add(analyzeTypeUnionAnnotation);
}

/// A function that does not transform the uri [input].
///
/// This will be used by default when creating library metadata.
Uri _uriNotChanged(Uri input) => input;
