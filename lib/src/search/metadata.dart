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
MetadataMatchFunction nameMatch(String name) =>
    (metadata) => metadata.name == name;

/// Matches metadata based on the given [type].
MetadataMatchFunction typeMatch(TypeMetadata type) =>
    (metadata) => metadata is ClassMetadata && metadata.type == type;
