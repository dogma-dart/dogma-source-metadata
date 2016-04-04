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
final FieldMetadata _staticField =
    new FieldMetadata.field('staticField', _fieldType, isStatic: true);
final FieldMetadata _instanceField =
    new FieldMetadata.field('instanceField', _fieldType, isStatic: false);
final Metadata _notStaticMetadata = new Metadata('NotStatic');

/// Entry point for tests.
void main() {
  test('staticMetadataMatch', () {
    expect(staticMetadataMatch(_staticField), isTrue);
    expect(staticMetadataMatch(_instanceField), isTrue);
    expect(staticMetadataMatch(_notStaticMetadata), isFalse);
  });
  test('abstractMatch', () {
    expect(staticMatch(_staticField), isTrue);
    expect(staticMatch(_instanceField), isFalse);
    expect(() => staticMatch(_notStaticMetadata), throws);
    expect(and(abstractMetadataMatch, staticMatch)(_notStaticMetadata), isFalse);
  });
  test('instanceMatch', () {
    expect(instanceMatch(_staticField), isFalse);
    expect(instanceMatch(_instanceField), isTrue);
    expect(() => instanceMatch(_notStaticMetadata), throws);
    expect(and(staticMetadataMatch, instanceMatch)(_notStaticMetadata), isFalse);
  });
}
