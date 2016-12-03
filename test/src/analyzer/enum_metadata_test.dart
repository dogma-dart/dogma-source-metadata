// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_metadata/analyzer.dart';
import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/path.dart';
import 'package:dogma_source_metadata/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

EnumMetadata _getEnum(LibraryMetadata library, String name) {
  final clazz = libraryMetadataQuery<ClassMetadata>(
      library,
      nameMatch(name),
      includeClasses: true
  );

  expect(clazz, isNotNull);
  expect(clazz.name, name);
  expect(clazz.enclosingMetadata, library);
  expect(clazz is EnumMetadata, isTrue);

  return clazz;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('enum tests', () {
    final library = libraryMetadata(join('test/lib/enum.dart'), context);

    final enumeration = _getEnum(library, 'Color');
    final values = enumeration.values;

    expect(values[0].name, 'red');
    expect(values[1].name, 'green');
    expect(values[2].name, 'blue');
  });
}
