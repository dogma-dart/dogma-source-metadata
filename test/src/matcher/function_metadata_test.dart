// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final FunctionMetadata _emptyParameters =
    new FunctionMetadata('emptyParameters', returnType: intType);
final FunctionMetadata _singleParameter =
    new FunctionMetadata(
        'singleParameter',
        returnType: intType,
        parameters: [new ParameterMetadata('_0', type: stringType)]
    );
final FunctionMetadata _twoParameters =
    new FunctionMetadata(
        'twoParameters',
        returnType: intType,
        parameters: [
          new ParameterMetadata('_0', type: stringType),
          new ParameterMetadata('_1', type: stringType)
        ]
    );
final Metadata _notFunctionMetadata = new Metadata('NotFunction');

/// Entry point for tests.
void main() {
  test('functionMetadataMatch', () {
    expect(functionMetadataMatch(_emptyParameters), isTrue);
    expect(functionMetadataMatch(_singleParameter), isTrue);
    expect(functionMetadataMatch(_twoParameters), isTrue);
    expect(functionMetadataMatch(_notFunctionMetadata), isFalse);
  });
  test('parameterCountMatch', () {
    final oneParameter = parameterCountMatch(1);
    final twoParameters = parameterCountMatch(2);

    expect(oneParameter(_emptyParameters), isFalse);
    expect(twoParameters(_emptyParameters), isFalse);

    expect(oneParameter(_singleParameter), isTrue);
    expect(twoParameters(_singleParameter), isFalse);

    expect(oneParameter(_twoParameters), isFalse);
    expect(twoParameters(_twoParameters), isTrue);

    expect(() => oneParameter(_notFunctionMetadata), throws);
    expect(and(functionMetadataMatch, oneParameter)(_notFunctionMetadata), isFalse);
  });
  test('emptyParametersMatch', () {
    expect(emptyParametersMatch(_emptyParameters), isTrue);
    expect(emptyParametersMatch(_singleParameter), isFalse);
    expect(emptyParametersMatch(_twoParameters), isFalse);

    expect(() => emptyParametersMatch(_notFunctionMetadata), throws);
    expect(and(functionMetadataMatch, emptyParametersMatch)(_notFunctionMetadata), isFalse);
  });
  test('returnTypeMatch', () {
    final returnsInt = returnTypeMatch(intType);
    final returnsString = returnTypeMatch(stringType);

    expect(returnsInt(_emptyParameters), isTrue);
    expect(returnsString(_emptyParameters), isFalse);

    expect(returnsInt(_singleParameter), isTrue);
    expect(returnsString(_singleParameter), isFalse);

    expect(returnsInt(_twoParameters), isTrue);
    expect(returnsString(_twoParameters), isFalse);

    expect(() => returnsInt(_notFunctionMetadata), throws);
    expect(and(functionMetadataMatch, returnsInt)(_notFunctionMetadata), isFalse);
  });
}
