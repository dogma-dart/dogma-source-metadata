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
typedef bool _ShouldLoadLibrary(LibraryElement element);

/// Loads the library at the given [path] into the analysis [context] and
/// begins processing it for metadata.
///
/// If a library cannot be found at the given [path] then the function will
/// return `null`.
LibraryMetadata libraryMetadata(Uri path,
                                AnalysisContext context,
                               {List<AnalyzeAnnotation> annotationCreators}) {
  annotationCreators ??= <AnalyzeAnnotation>[];
  _addDefaultAnnotationGenerators(annotationCreators);

  // Create the source from a URI
  //
  // This handles source based and package based URIs.
  var source = context.sourceFactory.forUri2(path);

  // Get the function used to determine which libraries should be loaded
  var shouldLoad = path.scheme == 'file'
      ? _checkFilePath
      : _checkPackagePath(path.pathSegments[0]);

  var kindOf = context.computeKindOf(source);

  if (kindOf == SourceKind.HTML) {
    throw new ArgumentError.value(path, 'path', 'Points to a HTML file and cannot be processed');
  } else if (kindOf == SourceKind.PART) {
    throw new ArgumentError.value(path, 'path', 'Points to a library part and not the library');
  } else if (kindOf == SourceKind.UNKNOWN) {
    _logger.warning('Source kind is unknown. Assuming optional library directive not present');
  }

  return _libraryMetadata(
      context.computeLibraryElement(source),
      {},
      shouldLoad,
      annotationCreators
  );
}

LibraryMetadata libraryMetadataFromElement(LibraryElement element,
                                          {List<AnalyzeAnnotation> annotationCreators}) {
  annotationCreators ??= <AnalyzeAnnotation>[];
  _addDefaultAnnotationGenerators(annotationCreators);

  var cached = <String, LibraryMetadata>{};
  var shouldLoad = (LibraryElement value) => false;

  return _libraryMetadata(element, cached, shouldLoad, annotationCreators);
}

/// Creates a function that checks the [libraryName] to determine if the
/// referenced library should be loaded.
_ShouldLoadLibrary _checkPackagePath(String libraryName) =>
    (element) {
      var uri = element.definingCompilationUnit.source.uri;

      if (uri.scheme == 'package') {
        return uri.pathSegments[0] == libraryName;
      } else {
        return false;
      }
    };

/// A function that just verifies that a file URI is being used by the
/// [element].
bool _checkFilePath(LibraryElement element) =>
    element.definingCompilationUnit.source.uri.scheme == 'file';

/// Searches the [library] element for metadata.
///
/// If no metadata is found within the library that is applicable then the
/// function will return `null`.
LibraryMetadata _libraryMetadata(LibraryElement library,
                                 Map<String, LibraryMetadata> cached,
                                 _ShouldLoadLibrary shouldLoad,
                                 List<AnalyzeAnnotation> annotationCreators) {
  // Use the URI
  var uri = library.definingCompilationUnit.source.uri;
  var uriString = uri.toString();

  // See if the library is in the cache
  if (cached.containsKey(uriString)) {
    return cached[uriString];
  }

  // Get the import and export directives
  var imports = uriReferenceList(library.imports);
  var exports = uriReferenceList(library.exports);

  var classes = <ClassMetadata>[];
  var functions = <FunctionMetadata>[];
  var fields = <FieldMetadata>[];

  for (var unit in library.units) {
    // Add class metadata
    for (var type in unit.types) {
      classes.add(classMetadata(type, annotationCreators));
    }

    // Add enum metadata
    for (var type in unit.enums) {
      classes.add(classMetadata(type, annotationCreators));
    }

    // Add function metadata
    for (var function in unit.functions) {
      functions.add(functionMetadata(function, annotationCreators));
    }

    for (var field in unit.topLevelVariables) {
      fields.add(fieldMetadata(field, annotationCreators));
    }
  }

  // Create the metadata
  var metadata = new LibraryMetadata(
      uri,
      name: library.name,
      imports: imports,
      exports: exports,
      classes: classes,
      functions: functions,
      fields: fields,
      annotations: createAnnotations(library, annotationCreators),
      comments: elementComments(library)
  );

  // Add to the cache
  cached[uriString] = metadata;

  // Load the referenced libraries
  //
  // This is done after adding to the cache to prevent circular references
  // from causing a stack overflow

  // Get the imported libraries
  var importCount = imports.length;
  assert(importCount == library.imports.length);

  for (var i = 0; i < importCount; ++i) {
    var importedLibrary = library.imports[i].importedLibrary;
    var importedUri = importedLibrary.source.uri;

    imports[i].library = shouldLoad(importedLibrary)
        ? _libraryMetadata(importedLibrary, cached, shouldLoad, annotationCreators)
        : new LibraryMetadata(importedUri);
  }

  var exportCount = exports.length;
  assert(exportCount == library.exports.length);

  for (var i = 0; i < exportCount; ++i) {
    var exportedLibrary = library.exports[i].exportedLibrary;
    var exportedUri = exportedLibrary.source.uri;

    exports[i].library = shouldLoad(exportedLibrary)
        ? _libraryMetadata(exportedLibrary, cached, shouldLoad, annotationCreators)
        : new LibraryMetadata(exportedUri);
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
