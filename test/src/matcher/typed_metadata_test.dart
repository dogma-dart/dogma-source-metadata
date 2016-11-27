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
import 'package:dogma_source_metadata/metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final TypeMetadata _intType = intType;
final TypeMetadata _stringType = stringType;
final TypeMetadata _fooType = interfaceType('Foo');

final FieldMetadata _intTyped = (field('intType')..type = _intType).build();
final FieldMetadata _stringTyped = (field('stringType')..type = _stringType).build();
final FieldMetadata _fooTyped = (field('fooType')..type = _fooType).build();
final Metadata _notTypedMetadata = new Metadata('NotTyped');

/// Entry point for tests.
void main() {
  test('typedMetadataMatch', () {
    expect(typedMetadataMatch(_intTyped), isTrue);
    expect(typedMetadataMatch(_stringTyped), isTrue);
    expect(typedMetadataMatch(_fooTyped), isTrue);
    expect(typedMetadataMatch(_notTypedMetadata), isFalse);
  });
  test('typeMatch', () {
    final intMatcher = typeMatch(_intType);
    final stringMatcher = typeMatch(_stringType);
    final fooMatcher = typeMatch(_fooType);

    expect(intMatcher(_intTyped), isTrue);
    expect(stringMatcher(_intTyped), isFalse);
    expect(fooMatcher(_intTyped), isFalse);

    expect(intMatcher(_stringTyped), isFalse);
    expect(stringMatcher(_stringTyped), isTrue);
    expect(fooMatcher(_stringTyped), isFalse);

    expect(intMatcher(_fooTyped), isFalse);
    expect(stringMatcher(_fooTyped), isFalse);
    expect(fooMatcher(_fooTyped), isTrue);

    expect(() => intMatcher(_notTypedMetadata), throws);
    expect(and(typedMetadataMatch, intMatcher)(_notTypedMetadata), isFalse);
  });
  /*
  test('builtinTypeMatch', () {
    expect(builtinTypeMatch(_intTyped), isTrue);
    expect(builtinTypeMatch(_stringTyped), isTrue);
    expect(builtinTypeMatch(_fooTyped), isFalse);
    expect(() => builtinTypeMatch(_notTypedMetadata), throws);
    expect(and(typedMetadataMatch, builtinTypeMatch)(_notTypedMetadata), isFalse);
  });
  */
}
