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

import 'expect_metadata.dart';
import 'function_metadata_validate.dart';
import 'metadata_validate.dart';
import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const String _name = 'function';

/// Test entry point.
void main() {
  test('validate name', expectThrowsOnUnnamed(method('')));
  test('validate parameter names', expectThrowsOnRepeatedNames(method(_name)));
  test('validate parameter order', expectThrowsOnInvalidPosition(method(_name)));
  test('validate optional and named', expectThrowsOnPositionalAndNamed(method(_name)));
  test('validate initializers', expectThrowsOnInitializers(method(_name)));
  test('validate static/abstract', () {
    final builder = new MethodMetadataBuilder()
        ..name = _name
        ..isAbstract = true
        ..isStatic = true;

    expectThrowsInvalidMetadataError(builder);
  });
  test('builder defaults', () {
    final builder = new MethodMetadataBuilder()
        ..name = _name;
    final expected = new MethodMetadata(_name);

    expectMetadataEqual<MethodMetadata>(builder, expected);
    expectMetadataEqual<MethodMetadata>(method(_name), expected);
  });
  test('values set', () {
    final returnType = intType;
    final paramName = 'param';
    final annotations = [deprecated];
    final comments = 'comment';

    final builder = new FunctionMetadataBuilder()
      ..name = _name
      ..returnType = returnType
      ..parameters = <ParameterMetadataBuilder>[
        parameter(paramName)
      ]
      ..annotations = annotations
      ..comments = comments;
    final expected = new FunctionMetadata(
        _name,
        returnType: returnType,
        parameters: <ParameterMetadata>[
          new ParameterMetadata(paramName)
        ]);

    expectMetadataEqual<FunctionMetadata>(builder, expected);

    // Make sure annotated metadata is present
    final actual = builder.build();

    expect(actual.annotations, hasLength(1));
    expect(actual, isDeprecated);
    expect(actual, commentedWith(comments));
  });
}
