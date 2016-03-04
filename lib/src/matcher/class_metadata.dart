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

/// Matches [metadata] that is an instance of [ClassMetadata].
bool classMetadataMatch(Metadata metadata) => metadata is ClassMetadata;

/// Matches class [metadata] whose supertype is the given [type].
MetadataMatchFunction supertypeMatch(TypeMetadata type) =>
    (metadata) => (metadata as ClassMetadata).supertype == type;

/// Matches class [metadata] that mixes in the given [type].
MetadataMatchFunction mixinMatch(TypeMetadata type) =>
    (metadata) => (metadata as ClassMetadata).mixins.contains(type);

/// Matches class [metadata] that implements the given [type].
MetadataMatchFunction interfaceMatch(TypeMetadata type) =>
    (metadata) => (metadata as ClassMetadata).interfaces.contains(type);

/// Matches class [metadata] that either descends or mixes in the given [type].
MetadataMatchFunction supertypeOrMixinMatch(TypeMetadata type) =>
    or(supertypeMatch(type), mixinMatch(type));

/// Matches class [metadata] that is generic.
bool genericClassMatch(Metadata metadata) =>
    (metadata as ClassMetadata).typeParameters.isNotEmpty;
