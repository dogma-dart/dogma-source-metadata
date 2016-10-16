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
    final returnType = new TypeMetadata('Foo');
    final metadata = new ConstructorMetadata(returnType);

    // Base classes
    expectAnnotatedMetadataDefaults(metadata);
    expectPrivacyMetadataDefaults(metadata);
    expectFunctionMetadataDefaults(metadata);

    // FunctionMetadata
    expect(metadata.returnType, returnType);
    expect(metadata.name, '');
    expect(metadata.isDefault, isTrue);
  });
  test('named constructor', () {
    final constructorName = 'bar';
    final returnType = new TypeMetadata('Foo');
    final metadata = new ConstructorMetadata.named(constructorName, returnType);

    // Base classes
    expectAnnotatedMetadataDefaults(metadata);
    expectPrivacyMetadataDefaults(metadata);
    expectFunctionMetadataDefaults(metadata);

    // FunctionMetadata
    expect(metadata.returnType, returnType);
    expect(metadata.name, constructorName);
    expect(metadata.isDefault, isFalse);
  });
}
