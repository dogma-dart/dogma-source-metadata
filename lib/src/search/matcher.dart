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

/// Function signature for a function that takes some [metadata] and returns
/// `true` if it matches some criteria and `false` otherwise.
typedef bool MetadataMatchFunction(Metadata metadata);

/// The default value for search includes.
///
/// By default the search is opt-in.
const bool defaultInclude = false;

/// Matches metadata based on the given [name].
MetadataMatchFunction nameMatch(String name) =>
    (metadata) => metadata.name == name;

/// Matches metadata based on the given [type].
MetadataMatchFunction typeMatch(TypeMetadata type) =>
    (metadata) => metadata is ClassMetadata && metadata.type == type;
