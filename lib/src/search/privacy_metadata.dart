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

/// Matches [metadata] that is an instance of [PrivacyMetadata].
bool privacyMetadataMatch(Metadata metadata) => metadata is PrivacyMetadata;

/// Matches [metadata] that is private.
///
/// The function assumes that [metadata] is [PrivacyMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [PrivacyMetadata] then this function should be joined with
/// privacyMetadataMatch.
///
///     and(privacyMetadataMatch, privateMatch);
bool privateMatch(Metadata metadata) => (metadata as PrivacyMetadata).isPrivate;

/// Matches [metadata] that is scoped to an instance.
///
/// The function assumes that [metadata] is [PrivacyMetadata]. For cases where
/// the metadata being queried can return instances of [Metadata] that are not
/// [PrivacyMetadata] then this function should be joined with
/// privacyMetadataMatch.
///
///     and(privacyMetadataMatch, publicMatch);
final MetadataMatchFunction publicMatch = not(privateMatch);
