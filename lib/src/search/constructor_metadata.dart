// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../matcher.dart';
import '../../metadata.dart';
import 'class_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

bool _defaultConstructorMatch(Metadata value) =>
    ((value is ConstructorMetadata) && (value.isDefault));

bool _factoryConstructorMatch(Metadata value) =>
    ((value is ConstructorMetadata) && (value.isFactory));

Metadata/*=ConstructorMetadata*/
    classDefaultConstructorQuery(ClassMetadata clazz) =>
        classMetadataQuery/*<ConstructorMetadata>*/(
            clazz,
            _defaultConstructorMatch,
            includeConstructors: true
        );

Iterable<Metadata/*=ConstructorMetadata*/>
    classPrivateConstructorQueryAll(ClassMetadata clazz) =>
        classMetadataQueryAll/*<ConstructorMetadata>*/(
            clazz,
            privateMatch,
            includeConstructors: true
        );

Iterable<Metadata/*=ConstructorMetadata*/>
    classFactoryConstructorQueryAll(ClassMetadata clazz) =>
        classMetadataQueryAll/*<ConstructorMetadata>*/(
            clazz,
            _factoryConstructorMatch,
            includeConstructors: true
        );

Iterable<Metadata/*=ConstructorMetadata*/>
    classNamedConstructorQueryAll(ClassMetadata clazz) =>
       classMetadataQueryAll/*<ConstructorMetadata>*/(
           clazz,
           not(_defaultConstructorMatch),
           includeConstructors: true
       );
