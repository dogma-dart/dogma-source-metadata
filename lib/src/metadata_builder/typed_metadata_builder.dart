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

/// Values for building typed metadata.
///
/// [TypedMetadataBuilder] should be mixed into the MetadataBuilder where
/// applicable.
class TypedMetadataBuilder {
  /// The type information.
  TypeMetadata type = dynamicType;
}
