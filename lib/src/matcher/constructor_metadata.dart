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

/// Matches [metadata] that is an instance of [ConstructorMetadata].
bool constructorMetadataMatch(Metadata metadata) =>
    metadata is ConstructorMetadata;

/// Matches constructor [metadata] that is a default constructor.
/// 
/// The function assumes that [metadata] is [ConstructorMetadata]. For cases 
/// where the metadata being queried can return instances of [Metadata] that 
/// are not [FieldMetadata] then this function should be joined with
/// [constructorMetadataMatch].
///
///     and(constructorMetadataMatch, defaultConstructorMatch);
bool defaultConstructorMatch(Metadata metadata) =>
    (metadata as ConstructorMetadata).isDefault;

/// Matches constructor [metadata] that is a factory constructor.
/// 
/// The function assumes that [metadata] is [ConstructorMetadata]. For cases 
/// where the metadata being queried can return instances of [Metadata] that 
/// are not [FieldMetadata] then this function should be joined with
/// [constructorMetadataMatch].
///
///     and(constructorMetadataMatch, defaultConstructorMatch);
bool factoryConstructorMatch(Metadata metadata) =>
    (metadata as ConstructorMetadata).isFactory;

/// Matches constructor [metadata] that is a named constructor.
/// 
/// The function assumes that [metadata] is [ConstructorMetadata]. For cases 
/// where the metadata being queried can return instances of [Metadata] that 
/// are not [FieldMetadata] then this function should be joined with
/// [constructorMetadataMatch].
///
///     and(constructorMetadataMatch, defaultConstructorMatch);
final MetadataMatchFunction namedConstructorMatch =
    not(defaultConstructorMatch);
