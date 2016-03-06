// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'metadata_match_function.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matches [metadata] that is an instance of [FieldMetadata].
bool fieldMetadataMatch(Metadata metadata) => metadata is FieldMetadata;

/// Matches field [metadata] that is final.
bool finalFieldMatch(Metadata metadata) => (metadata as FieldMetadata).isFinal;

/// Matches field [metadata] that uses properties.
bool propertyFieldMatch(Metadata metadata) =>
    (metadata as FieldMetadata).isProperty;

/// Matches field [metadata] that contains a getter.
bool getterFieldMatch(Metadata metadata) => (metadata as FieldMetadata).getter;

/// Matches field [metadata] that contains a setter.
bool setterFieldMatch(Metadata metadata) => (metadata as FieldMetadata).setter;

/// Matches field [metadata] that is a field.
final MetadataMatchFunction fieldMatch = not(propertyFieldMatch);
