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
    expect(field.isPrivate, false);
    expect(field.isPublic, true);
    expect(field.isStatic, true);
    expect(field.isProperty, false);
    expect(field.isConst, false);
    expect(field.getter, true);
    expect(field.setter, true);

    field = classFieldByNameQuery(clazz, 'classFinalField');
    expect(field, isNotNull);
    expect(field.name, 'classFinalField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, false);
    expect(field.isPublic, true);
    expect(field.isStatic, true);
    expect(field.isProperty, false);
    expect(field.isConst, false);
    expect(field.getter, true);
    expect(field.setter, false);

    field = classFieldByNameQuery(clazz, 'classConstField');
    expect(field, isNotNull);
    expect(field.name, 'classConstField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, false);
    expect(field.isPublic, true);
    expect(field.isStatic, true);
    expect(field.isProperty, false);
    expect(field.isConst, true);
    expect(field.getter, true);
    expect(field.setter, false);

    field = classFieldByNameQuery(clazz, '_classPrivateField');
    expect(field, isNotNull);
    expect(field.name, '_classPrivateField');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, true);
    expect(field.isPublic, false);
    expect(field.isStatic, true);
    expect(field.isProperty, false);
    expect(field.isConst, false);
    expect(field.getter, true);
    expect(field.setter, true);

    field = classFieldByNameQuery(clazz, 'classPrivateFieldGetter');
    expect(field, isNotNull);
    expect(field.name, 'classPrivateFieldGetter');
    expect(field.type, new TypeMetadata.string());
    expect(field.isPrivate, false);
    expect(field.isPublic, true);
    expect(field.isStatic, true);
    expect(field.isProperty, true);
    expect(field.isConst, false);
    expect(field.getter, true);
    expect(field.setter, false);
  });
}
