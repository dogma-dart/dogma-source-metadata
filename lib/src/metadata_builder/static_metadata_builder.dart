// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Values for building statically scoped metadata.
///
/// [StaticMetadataBuilder] should be mixed into the MetadataBuilder where
/// applicable.
class StaticMetadataBuilder {
  /// Whether the metadata is statically scoped.
  bool isStatic = false;
}
