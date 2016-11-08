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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const String _name = 'field';

/// Test entry point.
void main() {
  test('validate name', expectThrowsOnUnnamed(function('')));
  test('builder defaults', () {
    final builder = new FieldMetadataBuilder()
        ..name = _name;
    final expected = new FieldMetadata(_name);

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
    expectMetadataEqual/*<FieldMetadata>*/(field(_name), expected);
  });
  test('values set', () {

  });
  test('field', () {
    final builder = field(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: false,
        getter: true,
        setter: true
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
  test('constField', () {
    final builder = constField(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: false,
        getter: true,
        setter: false,
        isConst: true
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
  test('finalField', () {
    final builder = finalField(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: false,
        getter: true,
        setter: false,
        isFinal: true
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
  test('property', () {
    final builder = property(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: true,
        getter: true,
        setter: true
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
  test('getter', () {
    final builder = getter(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: true,
        getter: true,
        setter: false
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
  test('setter', () {
    final builder = setter(_name);
    final expected = new FieldMetadata(
        _name,
        isProperty: true,
        getter: false,
        setter: true
    );

    expectMetadataEqual/*<FieldMetadata>*/(builder, expected);
  });
}
