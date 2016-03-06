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

/// Matches [metadata] that is an instance of [ConstantMetadata].
bool constantMetadataMatch(Metadata metadata) => metadata is ConstantMetadata;

/// Matches field [metadata] that is constant.
bool constMatch(Metadata metadata) => (metadata as ConstantMetadata).isConst;
