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
import 'package:dogma_source_analyzer/metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final TypeMetadata _fieldType = intType;
final FieldMetadata _instanceField = field('instaceField').build();
final FieldMetadata _instanceFinalField = finalField('instanceField').build();
final FieldMetadata _instanceGetter = getter('instanceGetter').build();
final FieldMetadata _instanceSetter = setter('instanceSetter').build();
final Metadata _notFieldMetadata = new Metadata('NotField');

/// Entry point for tests.
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
