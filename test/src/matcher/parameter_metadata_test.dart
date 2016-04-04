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

final TypeMetadata _intType = new TypeMetadata.int();
final ParameterMetadata _required =
    new ParameterMetadata(
        'required',
        _intType,
        parameterKind: ParameterKind.required
    );
final ParameterMetadata _positional =
    new ParameterMetadata(
        'positional',
        _intType,
        parameterKind: ParameterKind.positional
    );
final ParameterMetadata _named =
    new ParameterMetadata(
        'named',
        _intType,
        parameterKind: ParameterKind.named
    );
final Metadata _notParameterMetadata = new Metadata('NotParameter');

/// Entry point for tests.
void main() {
  test('parameterMetadataMatch', () {
    expect(parameterMetadataMatch(_required), isTrue);
    expect(parameterMetadataMatch(_positional), isTrue);
    expect(parameterMetadataMatch(_named), isTrue);
    expect(parameterMetadataMatch(_notParameterMetadata), isFalse);
  });
  test('requiredParameterMatch', () {
    expect(requiredParameterMatch(_required), isTrue);
    expect(requiredParameterMatch(_positional), isFalse);
    expect(requiredParameterMatch(_named), isFalse);
    expect(() => requiredParameterMatch(_notParameterMetadata), throws);
    expect(and(parameterMetadataMatch, requiredParameterMatch)(_notParameterMetadata), isFalse);
  });
  test('optionalParameterMatch', () {
    expect(optionalParameterMatch(_required), isFalse);
    expect(optionalParameterMatch(_positional), isTrue);
    expect(optionalParameterMatch(_named), isTrue);
    expect(() => optionalParameterMatch(_notParameterMetadata), throws);
    expect(and(parameterMetadataMatch, optionalParameterMatch)(_notParameterMetadata), isFalse);
  });
  test('positionalParameterMatch', () {
    expect(positionalParameterMatch(_required), isFalse);
    expect(positionalParameterMatch(_positional), isTrue);
    expect(positionalParameterMatch(_named), isFalse);
    expect(() => positionalParameterMatch(_notParameterMetadata), throws);
    expect(and(parameterMetadataMatch, positionalParameterMatch)(_notParameterMetadata), isFalse);
  });
  test('namedParameterMatch', () {
    expect(namedParameterMatch(_required), isFalse);
    expect(namedParameterMatch(_positional), isFalse);
    expect(namedParameterMatch(_named), isTrue);
    expect(() => namedParameterMatch(_notParameterMetadata), throws);
    expect(and(parameterMetadataMatch, namedParameterMatch)(_notParameterMetadata), isFalse);
  });
}
