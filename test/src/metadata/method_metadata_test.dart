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

import 'base_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('default constructor', () {
    final methodName = 'foo';
    final metadata = new MethodMetadata(methodName);

    // Base classes
    expectAnnotatedMetadataDefaults(metadata);
    expectFunctionMetadataDefaults(metadata);

    // FunctionMetadata
    expect(metadata, isNamed(methodName));
    expect(metadata, returnsType(dynamicType));
  });
}
