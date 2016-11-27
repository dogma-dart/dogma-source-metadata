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

final TypeMetadata _fieldType = intType;
final FieldMetadata _staticField = (field('staticField')..isStatic = true).build();
final FieldMetadata _instanceField = field('instanceField').build();
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
