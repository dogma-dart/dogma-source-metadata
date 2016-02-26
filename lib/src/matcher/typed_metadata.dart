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

/// Matches [metadata] that is an instance of [TypedMetadata].
bool typedMetadataMatch(Metadata metadata) => metadata is TypedMetadata;

/// Matches typed metadata of the given [type].
MetadataMatchFunction typeMatch(TypeMetadata type) =>
    (metadata) => (metadata as TypedMetadata).type == type;

/// Matched typed [metadata] whose type is builtin.
bool builtinTypeMatch(Metadata metadata) =>
    (metadata as TypedMetadata).type.isBuiltin;
