// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Signifies that the metadata being constructed is invalid.
///
/// Metadata created through the MetadataBuilder is validated before the
/// metadata instance is created. If the metadata being constructed is not
/// valid for a Dart program then the [InvalidMetadataError] will be thrown.
class InvalidMetadataError extends StateError {
  /// Creates an instance of the [InvalidMetadataError] class.
  InvalidMetadataError(String message)
      : super(message);
}
