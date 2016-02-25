// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matches [metadata] that is an instance of [FieldMetadata].
bool fieldMetadataMatch(Metadata metadata) => metadata is FieldMetadata;

/// Matches field [metadata] that is constant.
///
/// The function assumes that [metadata] is [FieldMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [FieldMetadata] then this function should be joined with
/// fieldMetadataMatch.
///
///     and(fieldMetadataMatch, constFieldMatch);
bool constFieldMatch(Metadata metadata) => (metadata as FieldMetadata).isConst;

/// Matches field [metadata] that is final.
///
/// The function assumes that [metadata] is [FieldMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [FieldMetadata] then this function should be joined with
/// fieldMetadataMatch.
///
///     and(fieldMetadataMatch, finalFieldMatch);
bool finalFieldMatch(Metadata metadata) => (metadata as FieldMetadata).isFinal;
