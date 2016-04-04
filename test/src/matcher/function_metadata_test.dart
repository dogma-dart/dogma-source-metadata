// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final _intType = new TypeMetadata.int();
final _stringType = new TypeMetadata.string();

final FunctionMetadata _emptyParameters =
    new FunctionMetadata('emptyParameters', _intType);
final FunctionMetadata _singleParameter =
    new FunctionMetadata(
        'singleParameter',
        _intType,
        parameters: [new ParameterMetadata('_0', _stringType)]
    );
final FunctionMetadata _twoParameters =
    new FunctionMetadata(
        'twoParameters',
        _intType,
        parameters: [
          new ParameterMetadata('_0', _stringType),
          new ParameterMetadata('_1', _stringType)
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
    var oneParameter = parameterCountMatch(1);
    var twoParameters = parameterCountMatch(2);

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
    var returnsInt = returnTypeMatch(_intType);
    var returnsString = returnTypeMatch(_stringType);

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
