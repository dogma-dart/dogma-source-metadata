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

/// Matches [metadata] that is an instance of [StaticMetadata].
bool staticMetadataMatch(Metadata metadata) => metadata is StaticMetadata;

/// Matches [metadata] that is statically scoped.
///
/// The function assumes that [metadata] is [StaticMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [StaticMetadata] then this function should be joined with
/// staticMetadataMatch.
///
///     and(staticMetadataMatch, staticMatch);
bool staticMatch(Metadata metadata) => (metadata as StaticMetadata).isStatic;

/// Matches [metadata] that is scoped to an instance.
///
/// The function assumes that [metadata] is [StaticMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [StaticMetadata] then this function should be joined with
/// staticMetadataMatch.
///
///     and(abstractMetadataMatch, instanceMatch);
final MetadataMatchFunction instanceMatch = not(staticMatch);
