// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

import 'base_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('default constructor', () {
    final functionName = 'foo';
    final metadata = new MethodMetadata(functionName);

    // Base classes
    expectAnnotatedMetadataDefaults(metadata);
    expectPrivacyMetadataDefaults(metadata);
    expectFunctionMetadataDefaults(metadata);

    // FunctionMetadata
    expect(metadata.name, functionName);
    expect(metadata.returnType, dynamicType);
  });
}
