// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../matcher.dart';
import '../../metadata.dart';
import 'constants.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Creates an iterable containing the [library] and the imported and exported
/// libraries, dependent on whether [includeImports] and [includeExports] are
/// true.
///
/// The libraries will be returned in a breadth first search form. The
/// [library] is returned first, followed by imports, and then exports. These
/// will be returned recursively.
Iterable<LibraryMetadata> _libraries(LibraryMetadata library,
                                     bool includeImports,
                                     bool includeExports) sync* {
  yield library;

  if (includeImports) {
    for (var import in library.imported) {
      yield* _libraries(import, includeImports, includeExports);
    }
  }

  if (includeExports) {
    for (var export in library.exported) {
      yield* _libraries(export, includeImports, includeExports);
    }
  }
}

/// Gets the metadata held within a [library].
///
/// This just includes the values of classes, functions, and fields within the
/// library. The [includeClasses], [includeFunctions] and [includeFields] allow
/// those values to be toggled on and off.
Iterable<Metadata> _libraryMetadata(LibraryMetadata library,
                                    bool includeClasses,
                                    bool includeFunctions,
                                    bool includeFields,
                                    bool includeTypedefs) sync* {
  if (includeClasses) {
    yield* library.classes;
  }

  if (includeFunctions) {
    yield* library.functions;
  }

  if (includeFields) {
    yield* library.fields;
  }

  if (includeTypedefs) {
    yield* library.typedefs;
  }
}

/// Expands the metadata contained within the [library].
Iterable<Metadata /*=T*/>
    _expandLibraryMetadata/*<T extends Metadata>*/(LibraryMetadata library,
                                                   bool includeImports,
                                                   bool includeExports,
                                                   bool includeClasses,
                                                   bool includeFunctions,
                                                   bool includeFields,
                                                   bool includeTypedefs) {
  // Get the libraries to search through
  final searchLibraries = _libraries(library, includeImports, includeExports);

  // Expand the metadata within the library
  return searchLibraries.expand/*<T>*/(
      (value) =>
          _libraryMetadata(
              value,
              includeClasses,
              includeFunctions,
              includeFields,
              includeTypedefs
          )
  );
}

/// Queries the [library] for a single instance of metadata which passes the
/// checks within the [matcher].
Metadata/*=T*/
    libraryMetadataQuery/*<T extends Metadata>*/(LibraryMetadata library,
                                                 MetadataMatchFunction matcher,
                                                {bool includeImports: defaultInclude,
                                                 bool includeExports: defaultInclude,
                                                 bool includeClasses: defaultInclude,
                                                 bool includeFunctions: defaultInclude,
                                                 bool includeFields: defaultInclude,
                                                 bool includeTypedefs: defaultInclude}) =>
        _expandLibraryMetadata/*<T>*/(
            library,
            includeImports,
            includeExports,
            includeClasses,
            includeFunctions,
            includeFields,
            includeTypedefs
        ).firstWhere(matcher, orElse: () => null);

/// Queries the [library] for a single instance of metadata which passes the
/// checks within the [matcher].
Iterable<Metadata /*=T*/>
    libraryMetadataQueryAll/*<T extends Metadata>*/(LibraryMetadata library,
                                                    MetadataMatchFunction matcher,
                                                   {bool includeImports: defaultInclude,
                                                    bool includeExports: defaultInclude,
                                                    bool includeClasses: defaultInclude,
                                                    bool includeFunctions: defaultInclude,
                                                    bool includeFields: defaultInclude,
                                                    bool includeTypedefs: defaultInclude}) =>
        _expandLibraryMetadata/*<T>*/(
            library,
            includeImports,
            includeExports,
            includeClasses,
            includeFunctions,
            includeFields,
            includeTypedefs
        ).where(matcher);
