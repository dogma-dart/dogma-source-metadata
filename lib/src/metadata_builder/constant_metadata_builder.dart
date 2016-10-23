// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------


/// Values for building constant metadata.
///
/// [ConstantMetadataBuilder] should be mixed into the MetadataBuilder where
/// applicable.
class ConstantMetadataBuilder {
  /// Whether the metadata is constant.
  bool isConst = false;
}
