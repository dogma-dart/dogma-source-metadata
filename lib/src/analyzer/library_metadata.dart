// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/element.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:logging/logging.dart' as logging;

import '../../metadata.dart';
import 'class_metadata.dart';

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
                                AnalysisContext context) {
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

  return _libraryMetadata(context.computeLibraryElement(source), {}, shouldLoad);
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
                                 _ShouldLoadLibrary shouldLoad) {
  // Use the URI
  var uri = library.definingCompilationUnit.source.uri;
  var uriString = uri.toString();

  // See if the library is in the cache
  if (cached.containsKey(uriString)) {
    return cached[uriString];
  }

  var importedLibraries = <LibraryMetadata>[];
  var exportedLibraries = <LibraryMetadata>[];

  // Look at the dependencies for metadata
  for (var imported in library.importedLibraries) {
    if (shouldLoad(imported)) {
      importedLibraries.add(_libraryMetadata(imported, cached, shouldLoad));
    }
  }

  for (var exported in library.exportedLibraries) {
    if (shouldLoad(exported)) {
      exportedLibraries.add(_libraryMetadata(exported, cached, shouldLoad));
    }
  }

  var classes = <ClassMetadata>[];
  var functions = <FunctionMetadata>[];
  var fields = <FieldMetadata>[];

  for (var unit in library.units) {
    // Add class metadata
    for (var type in unit.types) {
      classes.add(classMetadata(type));
    }
  }

  // Create metadata if there was anything discovered
  //
  // Rather than doing an isEmpty on each of the lists the length is used and
  // if that length is greater than 0 then an instance of LibraryMetadata
  // should be created.
  var metadataCount =
      importedLibraries.length +
          exportedLibraries.length +
          classes.length +
          functions.length +
          fields.length;

  if (metadataCount > 0) {
    var metadata = new LibraryMetadata(
        library.name,
        uri,
        imported: importedLibraries,
        exported: exportedLibraries,
        classes: classes,
        functions: functions,
        fields: fields
    );

    cached[uriString] = metadata;

    return metadata;
  } else {
    return null;
  }
}
