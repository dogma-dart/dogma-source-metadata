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

Iterable<ClassMetadata> _classes(ClassMetadata clazz,
                                 bool includeInterfaces,
                                 bool includeSupertype,
                                 bool includeMixins) sync* {
  yield clazz;

  // \TODO search for super classes
}

Iterable<Metadata> _classMetadata(ClassMetadata clazz,
                                  bool includeFields,
                                  bool includeConstructors,
                                  bool includeMethods) sync* {
  if (includeFields) {
    yield* clazz.fields;
  }

  if (includeConstructors) {
    yield* clazz.constructors;
  }

  if (includeMethods) {
    yield* clazz.methods;
  }
}

Iterable<T>
    _expandClassMetadata<T extends Metadata>(ClassMetadata clazz,
                                             bool includeFields,
                                             bool includeConstructors,
                                             bool includeMethods) {
  // Get the classes to search through
  final searchClasses = _classes(clazz, false, false, false);

  // Expand the metadata within the library
  return searchClasses.expand<T>(
      (value) =>
          _classMetadata(
              value,
              includeFields,
              includeConstructors,
              includeMethods
          )
  );
}

/// Queries the [clazz] for a single instance of metadata which passes the
/// checks within the [matcher].
///
/// Classes contain fields, constructors and methods. When querying for
/// metadata the extent of the search can be specified by setting the
/// [includeFields], [includeConstructors], and [includeMethods] values. These
/// will default to the [defaultInclude] which is currently `false`.
///
/// When specifying a generic method only one of these values should be set
/// to true.
T classMetadataQuery<T extends Metadata>(ClassMetadata clazz,
                                         MetadataMatchFunction matcher,
                                        {bool includeFields: defaultInclude,
                                         bool includeConstructors: defaultInclude,
                                         bool includeMethods: defaultInclude}) =>
        _expandClassMetadata<T>(
            clazz,
            includeFields,
            includeConstructors,
            includeMethods,
        ).firstWhere(matcher, orElse: () => null);

/// Queries the [clazz] for a single instance of metadata which passes the
/// checks within the [matcher].
///
/// Classes contain fields, constructors and methods. When querying for
/// metadata the extent of the search can be specified by setting the
/// [includeFields], [includeConstructors], and [includeMethods] values. These
/// will default to the [defaultInclude] which is currently `false`.
///
/// When specifying a generic method only one of these values should be set
/// to true.
Iterable<T> classMetadataQueryAll<T extends Metadata>(ClassMetadata clazz,
                                                      MetadataMatchFunction matcher,
                                                     {bool includeFields: defaultInclude,
                                                      bool includeConstructors: defaultInclude,
                                                      bool includeMethods: defaultInclude}) =>
        _expandClassMetadata<T>(
            clazz,
            includeFields,
            includeConstructors,
            includeMethods,
        ).where(matcher);
