// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  var context = analysisContext();
  var fieldLibrary = libraryMetadata(join('test/lib/fields.dart'), context);

  test('field by name tests', () {

  });
  test('static field tests', () {
    var clazz = metadataByNameQuery/*<ClassMetadata>*/(
        fieldLibrary,
        'ClassFields',
        includeClasses: true
    );
    expect(clazz, isNotNull);

    var staticFields = classStaticFieldQueryAll(clazz);
    for (var field in staticFields) {
      expect(field.isStatic, isTrue);
    }
    expect(staticFields, hasLength(6));

    var staticConstFields = classMetadataQueryAll/*<FieldMetadata>*/(
        clazz,
        and(staticMatch, constFieldMatch),
        includeFields: true
    );
    expect(staticConstFields, hasLength(1));
    var staticConstField = staticConstFields.first as FieldMetadata;
    expect(staticConstField.name, 'classConstField');
    expect(staticConstField.isConst, isTrue);
    expect(staticConstField.isStatic, isTrue);
    expect(staticConstField.isFinal, isFalse);
  });
  test('instance field tests', () {

  });
}
