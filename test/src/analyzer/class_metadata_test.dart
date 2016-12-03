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

ClassMetadata _getClass(LibraryMetadata library, String name) {
  final clazz = libraryMetadataQuery<ClassMetadata>(
      library,
      nameMatch(name),
      includeClasses: true,
  );

  expect(clazz, isNotNull);
  expect(clazz.name, name);
  expect(clazz.enclosingMetadata, library);

  return clazz;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('inheritance tests', () {
    final library = libraryMetadata(join('test/lib/inheritance.dart'), context);

    final clazzA = _getClass(library, 'A');
    expect(clazzA.supertype, objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    final clazzB = _getClass(library, 'B');
    expect(clazzB.supertype, clazzA.type);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    final clazzC = _getClass(library, 'C');
    expect(clazzC.supertype, clazzB.type);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    final clazzD = _getClass(library, 'D');
    expect(clazzD.supertype, clazzC.type);
    expect(clazzD.interfaces, isEmpty);
    expect(clazzD.mixins, isEmpty);
  });
  test('interface tests', () {
    final library = libraryMetadata(join('test/lib/interfaces.dart'), context);

    final clazzA = _getClass(library, 'A');
    expect(clazzA.supertype, objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    final clazzB = _getClass(library, 'B');
    expect(clazzB.supertype, objectType);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    final clazzC = _getClass(library, 'C');
    expect(clazzC.supertype, objectType);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    final clazzD = _getClass(library, 'D');
    expect(clazzD.supertype, objectType);
    expect(clazzD.mixins, isEmpty);

    expect(clazzD.interfaces, hasLength(3));
    expect(clazzD.interfaces, contains(clazzA.type));
    expect(clazzD.interfaces, contains(clazzB.type));
    expect(clazzD.interfaces, contains(clazzC.type));
  });
  test('mixin tests', () {
    final library = libraryMetadata(join('test/lib/mixins.dart'), context);

    final clazzA = _getClass(library, 'A');
    expect(clazzA.supertype, objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    final clazzB = _getClass(library, 'B');
    expect(clazzB.supertype, objectType);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    final clazzC = _getClass(library, 'C');
    expect(clazzC.supertype, objectType);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    final clazzD = _getClass(library, 'D');
    expect(clazzD.supertype, clazzA.type);
    expect(clazzD.interfaces, isEmpty);

    expect(clazzD.mixins, hasLength(2));
    expect(clazzD.mixins, contains(clazzB.type));
    expect(clazzD.mixins, contains(clazzC.type));
  });
}
