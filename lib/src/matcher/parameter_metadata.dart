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

/// Matches metadata based on the given [name].
bool requiredParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).isRequired;

final MetadataMatchFunction optionalParameterMatch =
    not(requiredParameterMatch);

bool positionalParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).parameterKind == ParameterKind.positional;

bool namedParameterMatch(Metadata metadata) =>
    (metadata as ParameterMetadata).parameterKind == ParameterKind.named;
