// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_metadata/matcher.dart' as match;
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/metadata_builder.dart';
import 'package:dogma_source_metadata/query.dart';

import 'expect_metadata.dart';
import 'invalid_metadata_error.dart';
import 'metadata_validate.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('validate name', expectThrowsOnUnnamed(enumerations('', ['foo'])));
  test('validate has values', () => expectThrowsInvalidMetadataError(enumeration('Foo')));
  test('enumeration default values', () {
    final values = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];
    final metadata = enumerations('Test', values).build();

    final valueCount = values.length;
    for (var i = 0; i < valueCount; ++i) {
      final enumeration = classMetadataQuery<FieldMetadata>(
          metadata,
          match.nameMatch(values[i]),
          includeFields: true,
      );

      expect(enumeration, isNotNull);
      expect(enumeration, isStatic);
      expect(enumeration, isConstant);
      expect(enumeration.defaultValue, equals(i));
    }
  });
}
