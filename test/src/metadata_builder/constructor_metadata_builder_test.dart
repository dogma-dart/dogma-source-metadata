// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/metadata_builder.dart';

import 'expect_metadata.dart';
import 'metadata_validate.dart';
import 'function_metadata_validate.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('unnamed', expectUnnamed(defaultConstructor()));
  test('validate parameter names', expectThrowsOnRepeatedNames(defaultConstructor()));
  test('validate parameter order', expectThrowsOnInvalidPosition(defaultConstructor()));
  test('validate optional and named', expectThrowsOnPositionalAndNamed(defaultConstructor()));
  test('validate initializers', expectThrowsOnInitializers(defaultConstructor()..isFactory = true));
  test('builder defaults', () {
    final returnType = type('Foo');
    final builder = new ConstructorMetadataBuilder()
        ..returnType = returnType;
    final expected = new ConstructorMetadata(returnType);

    expectMetadataEqual/*<ConstructorMetadata>*/(builder, expected);
    expectMetadataEqual/*<ConstructorMetadata>*/(defaultConstructor()..returnType = returnType, expected);
  });
  test('initializers', () {
    final builder = defaultConstructor()
        ..parameters = <ParameterMetadataBuilder>[
          parameter('test')
              ..isInitializer = true
        ];
    final built = builder.build();
    expect(built.parameters, hasLength(1));

    final param = built.parameters[0];
    expect(param.isInitializer, isTrue);
  });
}
