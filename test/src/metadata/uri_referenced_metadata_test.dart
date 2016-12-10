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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('default constructor', () {
    final metadata = new UriReferencedMetadata();

    expect(metadata, notPrefixed);
    expect(metadata, notDeferred);
    expect(metadata, showsAllNames);
    expect(metadata, hidesNoNames);
    expect(metadata, notConfigurationImport);
  });
}
