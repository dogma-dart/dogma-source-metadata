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

/// Matches [metadata] that is an instance of [AbstractMetadata].
bool abstractMetadataMatch(Metadata metadata) => metadata is AbstractMetadata;

/// Matches [metadata] that is abstract.
///
/// The function assumes that [metadata] is [AbstractMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [AbstractMetadata] then this function should be joined with
/// abstractMetadataMatch.
///
///     and(abstractMetadataMatch, abstractMatch);
bool abstractMatch(Metadata metadata) =>
    (metadata as AbstractMetadata).isAbstract;

/// Matches [metadata] that is concrete.
///
/// The function assumes that [metadata] is [AbstractMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [AbstractMetadata] then this function should be joined with
/// abstractMetadataMatch.
///
///     and(abstractMetadataMatch, concreteMatch);
final MetadataMatchFunction concreteMatch = not(abstractMatch);
