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
bool privateMatch(Metadata metadata) => (metadata as PrivacyMetadata).isPrivate;

/// Matches [metadata] that is scoped to an instance.
final MetadataMatchFunction publicMatch = not(privateMatch);
