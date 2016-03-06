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

final TypeMetadata _fieldType = new TypeMetadata.int();
final FieldMetadata _instanceField =
    new FieldMetadata.field(
        'instanceField',
        _fieldType,
        isConst: false,
        isFinal: false
    );
final FieldMetadata _instanceFinalField =
    new FieldMetadata.field(
        'instanceField',
        _fieldType,
        isConst: false,
        isFinal: true
    );
final FieldMetadata _instanceGetter =
    new FieldMetadata(
        'instanceGetter',
        _fieldType,
        true,
        true,
        false,
        isConst: false,
        isFinal: false
    );
final FieldMetadata _instanceSetter =
    new FieldMetadata(
        'instanceSetter',
        _fieldType,
        true,
        false,
        true,
        isConst: false,
        isFinal: false
    );
final Metadata _notFieldMetadata = new Metadata('NotField');

void main() {
  test('fieldMetadataMatch', () {
    expect(fieldMetadataMatch(_instanceField), isTrue);
    expect(fieldMetadataMatch(_instanceFinalField), isTrue);
    expect(fieldMetadataMatch(_instanceGetter), isTrue);
    expect(fieldMetadataMatch(_instanceSetter), isTrue);
    expect(fieldMetadataMatch(_notFieldMetadata), isFalse);
  });
  test('finalFieldMatch', () {
    expect(finalFieldMatch(_instanceField), isFalse);
    expect(finalFieldMatch(_instanceFinalField), isTrue);
    expect(finalFieldMatch(_instanceGetter), isFalse);
    expect(finalFieldMatch(_instanceSetter), isFalse);
    expect(() => finalFieldMatch(_notFieldMetadata), throws);
    expect(and(fieldMetadataMatch, finalFieldMatch)(_notFieldMetadata), isFalse);
  });
  test('propertyFieldMatch', () {
    expect(propertyFieldMatch(_instanceField), isFalse);
    expect(propertyFieldMatch(_instanceFinalField), isFalse);
    expect(propertyFieldMatch(_instanceGetter), isTrue);
    expect(propertyFieldMatch(_instanceSetter), isTrue);
    expect(() => propertyFieldMatch(_notFieldMetadata), throws);
    expect(and(fieldMetadataMatch, propertyFieldMatch)(_notFieldMetadata), isFalse);
  });
  test('getterFieldMatch', () {
    expect(getterFieldMatch(_instanceField), isTrue);
    expect(getterFieldMatch(_instanceFinalField), isTrue);
    expect(getterFieldMatch(_instanceGetter), isTrue);
    expect(getterFieldMatch(_instanceSetter), isFalse);
    expect(() => getterFieldMatch(_notFieldMetadata), throws);
    expect(and(fieldMetadataMatch, getterFieldMatch)(_notFieldMetadata), isFalse);
  });
  test('setterFieldMatch', () {
    expect(setterFieldMatch(_instanceField), isTrue);
    expect(setterFieldMatch(_instanceFinalField), isFalse);
    expect(setterFieldMatch(_instanceGetter), isFalse);
    expect(setterFieldMatch(_instanceSetter), isTrue);
    expect(() => setterFieldMatch(_notFieldMetadata), throws);
    expect(and(fieldMetadataMatch, setterFieldMatch)(_notFieldMetadata), isFalse);
  });
  test('fieldMatch', () {
    expect(fieldMatch(_instanceField), isTrue);
    expect(fieldMatch(_instanceFinalField), isTrue);
    expect(fieldMatch(_instanceGetter), isFalse);
    expect(fieldMatch(_instanceSetter), isFalse);
    expect(() => fieldMatch(_notFieldMetadata), throws);
    expect(and(fieldMetadataMatch, fieldMatch)(_notFieldMetadata), isFalse);
  });
}
