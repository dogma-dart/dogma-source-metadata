// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matcher for an [InvalidMetadataError] being thrown.
final Matcher throwsInvalidMetadataError =
    throwsA(new isInstanceOf<InvalidMetadataError>());

/// Expect that the [builder] will throw an [InvalidMetadataError].
void expectThrowsInvalidMetadataError(MetadataBuilder builder) {
  expect(() => builder.build(), throwsInvalidMetadataError);
}
