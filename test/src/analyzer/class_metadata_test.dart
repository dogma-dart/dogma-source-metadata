// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final _objectType = new TypeMetadata('Object');

ClassMetadata _getClass(String name, LibraryMetadata library) {
  var clazz = metadataByNameQuery/*<ClassMetadata*/(
      library,
      name,
      includeClasses: true
  ) as ClassMetadata;

  expect(clazz, isNotNull);
  expect(clazz.name, name);
  expect(clazz.enclosingMetadata, library);

  return clazz;
}

void main() {
  var context = analysisContext();

  test('inheritance tests', () {
    var library = libraryMetadata(join('test/lib/inheritance.dart'), context);

    var clazzA = _getClass('A', library);
    expect(clazzA.supertype, _objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    var clazzB = _getClass('B', library);
    expect(clazzB.supertype, clazzA.type);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    var clazzC = _getClass('C', library);
    expect(clazzC.supertype, clazzB.type);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    var clazzD = _getClass('D', library);
    expect(clazzD.supertype, clazzC.type);
    expect(clazzD.interfaces, isEmpty);
    expect(clazzD.mixins, isEmpty);
  });
  test('interface tests', () {
    var library = libraryMetadata(join('test/lib/interfaces.dart'), context);

    var clazzA = _getClass('A', library);
    expect(clazzA.supertype, _objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    var clazzB = _getClass('B', library);
    expect(clazzB.supertype, _objectType);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    var clazzC = _getClass('C', library);
    expect(clazzC.supertype, _objectType);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    var clazzD = _getClass('D', library);
    expect(clazzD.supertype, new TypeMetadata('Object'));
    expect(clazzD.mixins, isEmpty);

    expect(clazzD.interfaces, hasLength(3));
    expect(clazzD.interfaces, contains(clazzA.type));
    expect(clazzD.interfaces, contains(clazzB.type));
    expect(clazzD.interfaces, contains(clazzC.type));
  });
  test('mixin tests', () {
    var library = libraryMetadata(join('test/lib/mixins.dart'), context);

    var clazzA = _getClass('A', library);
    expect(clazzA.supertype, _objectType);
    expect(clazzA.interfaces, isEmpty);
    expect(clazzA.mixins, isEmpty);

    var clazzB = _getClass('B', library);
    expect(clazzB.supertype, _objectType);
    expect(clazzB.interfaces, isEmpty);
    expect(clazzB.mixins, isEmpty);

    var clazzC = _getClass('C', library);
    expect(clazzC.supertype, _objectType);
    expect(clazzC.interfaces, isEmpty);
    expect(clazzC.mixins, isEmpty);

    var clazzD = _getClass('D', library);
    expect(clazzD.supertype, clazzA.type);
    expect(clazzD.interfaces, isEmpty);

    expect(clazzD.mixins, hasLength(2));
    expect(clazzD.mixins, contains(clazzB.type));
    expect(clazzD.mixins, contains(clazzC.type));
  });
}
