// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/metadata_builder.dart';

import 'expect_metadata.dart';
import 'metadata_validate.dart';
import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const String _name = 'test';

/// Test entry point.
void main() {
  test('validate name', expectThrowsOnUnnamed(parameter('')));
  test('validate required no default', () {
    final builder = parameter(_name)
      ..defaultValue = 5;

    expectThrowsInvalidMetadataError(builder);
  });
  test('builder defaults', () {
    final builder = new ParameterMetadataBuilder()
        ..name = _name;
    final expected = new ParameterMetadata(_name);

    expectMetadataEqual/*<ParameterMetadata>*/(builder, expected);
    expectMetadataEqual/*<ParameterMetadata>*/(parameter(_name), expected);
  });
  test('values set', () {
    final parameterKind = ParameterKind.positional;
    final type = intType;
    final isInitializer = true;
    final defaultValue = 5;
    final annotations = [deprecated];

    final builder = new ParameterMetadataBuilder()
        ..name = _name
        ..type = type
        ..parameterKind = parameterKind
        ..isInitializer = isInitializer
        ..defaultValue = defaultValue
        ..annotations = annotations;
    final expected = new ParameterMetadata(
        _name,
        type: type,
        parameterKind: parameterKind,
        isInitializer: isInitializer,
        defaultValue: defaultValue
    );

    expectMetadataEqual/*<ParameterMetadata>*/(builder, expected);

    // Make sure annotated metadata is present
    //
    // Comments are not valid on parameters
    final actual = builder.build();

    expect(actual.annotations, hasLength(1));
    expect(actual, isDeprecated);
  });
  test('parameter', () {
    final builder = parameter(_name);
    final expected = new ParameterMetadata(
        _name,
        parameterKind: ParameterKind.required
    );

    expectMetadataEqual/*<ParameterMetadata>*/(builder, expected);
  });
  test('positionalParameter', () {
    final builder = positionalParameter(_name);
    final expected = new ParameterMetadata(
        _name,
        parameterKind: ParameterKind.positional
    );

    expectMetadataEqual/*<ParameterMetadata>*/(builder, expected);
  });
  test('namedParameter', () {
    final builder = namedParameter(_name);
    final expected = new ParameterMetadata(
        _name,
        parameterKind: ParameterKind.named
    );

    expectMetadataEqual/*<ParameterMetadata>*/(builder, expected);
  });
}
