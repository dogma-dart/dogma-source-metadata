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
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  var context = analysisContext();

  test('Field tests', () {
    var library = libraryMetadata(join('test/lib/fields.dart'), context);

    // Get the class
    var clazz = metadataByNameQuery/*<ClassMetadata>*/(
        library,
        'ClassFields',
        includeClasses: true
    );

    expect(clazz, isNotNull);

    // Get the static fields
    var field;

    field = classFieldByNameQuery(clazz, 'classField');
    expect(field, isNotNull);
    expect(field.name, 'classField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isTrue);

    field = classFieldByNameQuery(clazz, 'classFinalField');
    expect(field, isNotNull);
    expect(field.name, 'classFinalField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);

    field = classFieldByNameQuery(clazz, 'classConstField');
    expect(field, isNotNull);
    expect(field.name, 'classConstField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isTrue);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);

    field = classFieldByNameQuery(clazz, '_classPrivateField');
    expect(field, isNotNull);
    expect(field.name, '_classPrivateField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, isTrue);
    expect(field.isPublic, isFalse);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isFalse);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isTrue);

    field = classFieldByNameQuery(clazz, 'classPrivateFieldGetter');
    expect(field, isNotNull);
    expect(field.name, 'classPrivateFieldGetter');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, isFalse);
    expect(field.isPublic, isTrue);
    expect(field.isStatic, isTrue);
    expect(field.isProperty, isTrue);
    expect(field.isConst, isFalse);
    expect(field.getter, isTrue);
    expect(field.setter, isFalse);
  });
}
