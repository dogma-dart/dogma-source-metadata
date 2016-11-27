// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void expectMetadataEqual/*<T extends Metadata>*/(MetadataBuilder/*<T>*/ actual,
                                                 Metadata/*=T*/ expected) {
  expect(actual.build(), metadataEqual/*<T>*/(expected));
}
