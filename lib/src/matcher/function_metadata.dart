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

/// Matches function [metadata] with [count] number of parameters.
MetadataMatchFunction parameterCountMatch(int count) =>
    (metadata) => (metadata as FunctionMetadata).parameters.length == count;

/// Matches function [metadata] with no parameters.
final MetadataMatchFunction emptyParametersMatch = parameterCountMatch(0);
