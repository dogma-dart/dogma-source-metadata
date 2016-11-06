// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:dogma_source_analyzer/metadata_builder.dart';
import 'package:test/test.dart';

import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Signature for a function used by [expect].
typedef void TestFunction();

/// Built metadata should have no name.
TestFunction expectUnnamed(MetadataBuilder builder) => () {
  builder.name = '';

  expect(builder.build(), isNamed(''));
};

/// Builder should error on unnamed metadata.
TestFunction expectThrowsOnUnnamed(MetadataBuilder builder) => () {
  builder.name = '';

  expectThrowsInvalidMetadataError(builder);
};
