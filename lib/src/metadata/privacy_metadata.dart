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

/// Contains metadata for a method.
abstract class PrivacyMetadata implements Metadata {
  /// Whether the metadata is private to the library.
  bool get isPrivate => name.startsWith('_');

  /// Whether the metadata is public to the library.
  bool get isPublic => !isPrivate;
}
