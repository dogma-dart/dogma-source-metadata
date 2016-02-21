// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'abstract_metadata.dart';
import 'constants.dart';
import 'field_metadata.dart';
import 'metadata.dart';
import 'metadata_match_function.dart';
import 'static_metadata.dart';

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

Iterable<Metadata /*=T*/>
    _expandClassMetadata/*<T extends Metadata>*/(ClassMetadata clazz,
                                                 bool includeFields,
                                                 bool includeConstructors,
                                                 bool includeMethods) {
  // Get the classes to search through
  var searchClasses = _classes(clazz, false, false, false);

  // Expand the metadata within the library
  return searchClasses.expand(
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
Metadata/*=T*/
    classMetadataQuery/*<T extends Metadata>*/(ClassMetadata clazz,
                                               MetadataMatchFunction matcher,
                                              {includeFields: defaultInclude,
                                               includeConstructors: defaultInclude,
                                               includeMethods: defaultInclude}) =>
        _expandClassMetadata/*<T>*/(
            clazz,
            includeFields,
            includeConstructors,
            includeMethods
        ).firstWhere(matcher, orElse: () => null);

/// Queries the [clazz] for a single instance of metadata which passes the
/// checks within the [matcher].
Iterable<Metadata/*=T*/>
   classMetadataQueryAll/*<T extends Metadata>*/(ClassMetadata clazz,
                                                 MetadataMatchFunction matcher,
                                                {includeFields: defaultInclude,
                                                 includeConstructors: defaultInclude,
                                                 includeMethods: defaultInclude}) =>
        _expandClassMetadata/*<T>*/(
            clazz,
            includeFields,
            includeConstructors,
            includeMethods
        ).where(matcher);

Metadata/*=FieldMetadata*/
    classFieldByNameQuery(ClassMetadata clazz, String name) =>
        classMetadataQuery/*<FieldMetadata>*/(
            clazz,
            nameMatch(name),
            includeFields: true
        );

Iterable<Metadata/*=FieldMetadata*/>
    classInstanceFieldQueryAll(ClassMetadata clazz) =>
        classMetadataQueryAll/*<FieldMetadata>*/(
            clazz,
            instanceMatch,
            includeFields: true
        );

Iterable<Metadata/*=FieldMetadata*/>
    classStaticFieldQueryAll(ClassMetadata clazz) =>
        classMetadataQueryAll/*<FieldMetadata>*/(
            clazz,
            staticMatch,
            includeFields: true
        );

Iterable<Metadata/*=FieldMetadata*/>
    classConstFieldQueryAll(ClassMetadata clazz) =>
        classMetadataQueryAll/*<FieldMetadata>*/(
            clazz,
            constFieldMatch,
            includeFields: true
        );

/// Queries all fields within the [metadata] that are abstract.
Iterable<Metadata/*=FieldMetadata*/>
    classAbstractFieldQueryAll(ClassMetadata metadata) =>
        classMetadataQueryAll/*<FieldMetadata>*/(
            metadata,
            abstractMatch,
            includeFields: true
        );

/// Queries all fields within the [metadata] that are concrete.
Iterable<Metadata/*=FieldMetadata*/>
    classConcreteFieldQueryAll(ClassMetadata metadata) =>
        classMetadataQueryAll/*<FieldMetadata>*/(
            metadata,
            concreteMatch,
            includeFields: true
        );
