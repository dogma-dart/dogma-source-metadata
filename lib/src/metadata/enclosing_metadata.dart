// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata that is enclosed by other metadata.
///
/// Allows a linkage between this metadata and the metadata that contains it.
abstract class EnclosedMetadata implements Metadata {
  /// The metadata enclosing this metadata.
  Metadata _enclosingMetadata;

  /// The metadata enclosing this metadata.
  Metadata get enclosingMetadata => _enclosingMetadata;
}

/// Metadata that encloses other metadata.
///
/// Contains functionality to link metadata enclosed by this metadata.
abstract class EnclosingMetadata implements Metadata {
  /// Marks the [metadata] as enclosed by this.
  void enclose(EnclosedMetadata metadata) {
    assert(metadata._enclosingMetadata == null);
    metadata._enclosingMetadata = this;
  }

  /// Marks all the [metadata] as enclosed by this.
  void encloseList(Iterable<EnclosedMetadata> metadata) {
    for (var value in metadata) {
      enclose(value);
    }
  }
}
