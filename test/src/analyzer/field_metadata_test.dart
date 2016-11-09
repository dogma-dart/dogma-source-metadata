// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

FieldMetadata _getField(ClassMetadata clazz, String name) {
  final field = classMetadataQuery/*<FieldMetadata>*/(
      clazz,
      nameMatch(name),
      includeFields: true
  );

  expect(field, isNotNull);
  expect(field.enclosingMetadata, clazz);

  return field;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('Field tests', () {
    final library = libraryMetadata(join('test/lib/fields.dart'), context);

    // Get the class
    final clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('ClassFields'),
        includeClasses: true
    );

    expect(clazz, isNotNull);

    // Get the static fields
    var field;

    field = _getField(clazz, 'classField');
    expect(field, isNotNull);
    expect(field.name, 'classField');
    expect(field.type, stringType);
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isTrue);

    field = _getField(clazz, 'classFinalField');
    expect(field, isNotNull);
    expect(field.name, 'classFinalField');
    expect(field.type, stringType);
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);

    field = _getField(clazz, 'classConstField');
    expect(field, isNotNull);
    expect(field.name, 'classConstField');
    expect(field.type, stringType);
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isTrue);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);

    field = _getField(clazz, '_classPrivateField');
    expect(field, isNotNull);
    expect(field.name, '_classPrivateField');
    expect(field.type, stringType);
    expect(field.isPrivate, isTrue);
    expect(field.isPublic, isFalse);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isTrue);

    field = _getField(clazz, 'classPrivateFieldGetter');
    expect(field, isNotNull);
    expect(field.name, 'classPrivateFieldGetter');
    expect(field.type, stringType);
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isTrue);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);
  });
}
