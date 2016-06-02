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

/// Matches [metadata] that is an instance of [ParameterMetadata].
bool parameterMetadataMatch(Metadata metadata) => metadata is ParameterMetadata;

/// Matches parameter [metadata] that is required to be present.
bool requiredParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).isRequired;

/// Matches parameter metadata which is optional.
///
/// This matches both positional and named parameters.
final MetadataMatchFunction optionalParameterMatch =
    not(requiredParameterMatch);

/// Matches parameter [metadata] which is positional.
bool positionalParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).parameterKind == ParameterKind.positional;

/// Matches parameter [metadata] which is named.
bool namedParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).parameterKind == ParameterKind.named;
