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

void _expectFieldDefaults(FieldMetadata metadata) {
  expect(metadata.isConst, isFalse);
  expect(metadata.isAbstract, isFalse);
  expect(metadata.isFinal, isFalse);
  expect(metadata.defaultValue, isNull);
}

/// Test entry point.
void main() {
  test('default constructor', () {
    final fieldName = 'field';
    final fieldType = new TypeMetadata.bool();
    final fieldIsProperty = true;
    final fieldGetter = true;
    final fieldSetter = true;

    final field = new FieldMetadata(
        fieldName,
        fieldType,
        fieldIsProperty,
        fieldGetter,
        fieldSetter
    );

    // Base classes
    expectAnnotatedMetadataDefaults(field);
    expectPrivacyMetadataDefaults(field);
    expectStaticMetadataDefaults(field);

    // FieldMetadata
    _expectFieldDefaults(field);

    expect(field.name, fieldName);
    expect(field.type, fieldType);
    expect(field.isProperty, fieldIsProperty);
    expect(field.getter, fieldGetter);
    expect(field.setter, fieldSetter);
  });

  test('field constructor', () {
    // Default field
    final fieldName = 'field';
    final fieldType = new TypeMetadata.bool();
    final field = new FieldMetadata.field(fieldName, fieldType);

    // Base classes
    expectAnnotatedMetadataDefaults(field);
    expectPrivacyMetadataDefaults(field);
    expectStaticMetadataDefaults(field);

    // FieldMetadata
    _expectFieldDefaults(field);

    expect(field.name, fieldName);
    expect(field.type, fieldType);
    expect(field.isProperty, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isTrue);

    // Const field
    final constFieldName = 'constField';
    final constFieldType = new TypeMetadata.bool();
    final constField = new FieldMetadata.field(
        constFieldName,
        constFieldType,
        isConst: true
    );

    // Base classes
    expectAnnotatedMetadataDefaults(constField);
    expectPrivacyMetadataDefaults(constField);
    expectStaticMetadataDefaults(constField);

    // FieldMetadata
    expect(constField.name, constFieldName);
    expect(constField.type, constFieldType);
    expect(constField.isProperty, isFalse);
    expect(constField.getter, isTrue);
    expect(constField.setter, isFalse);
    expect(constField.isConst, isTrue);
    expect(constField.isFinal, isFalse);
    expect(constField.defaultValue, isNull);

    // Final field
    final finalFieldName = 'finalField';
    final finalFieldType = new TypeMetadata.bool();
    final finalField = new FieldMetadata.field(
        finalFieldName,
        finalFieldType,
        isFinal: true
    );

    // Base classes
    expectAnnotatedMetadataDefaults(finalField);
    expectPrivacyMetadataDefaults(finalField);
    expectStaticMetadataDefaults(finalField);

    // FieldMetadata
    expect(finalField.name, finalFieldName);
    expect(finalField.type, finalFieldType);
    expect(finalField.isProperty, isFalse);
    expect(finalField.getter, isTrue);
    expect(finalField.setter, isFalse);
    expect(finalField.isConst, isFalse);
    expect(finalField.isFinal, isTrue);
    expect(finalField.defaultValue, isNull);
  });
}
