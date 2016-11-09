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
final FieldMetadata _constField = constField('constField').build();
final FieldMetadata _field = finalField('field').build();
final Metadata _notConstantMetadata = new Metadata('NotConstant');

/// Entry point for tests.
void main() {
  test('constantMetadataMatch', () {
    expect(constantMetadataMatch(_constField), isTrue);
    expect(constantMetadataMatch(_field), isTrue);
    expect(constantMetadataMatch(_notConstantMetadata), isFalse);
  });
  test('constMatch', () {
    expect(constMatch(_constField), isTrue);
    expect(constMatch(_field), isFalse);
    expect(() => constMatch(_notConstantMetadata), throws);
    expect(and(constantMetadataMatch, constMatch)(_notConstantMetadata), isFalse);
  });
}
