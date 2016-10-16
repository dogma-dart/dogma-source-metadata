// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';

import '../../lib/mirrors.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

const String _class = 'A';
const String _library = 'dogma_source_analyzer.test.lib.mirrors';
const String _function = 'function';
const String _notFound = 'NotFound';

/// Entry point for tests.
void main() {
  test('classMirror tests', () {
    var mirror;

    mirror = classMirror(_class);
    expect(mirror, isNotNull);

    mirror = classMirror(_class, _library);
    expect(mirror, isNotNull);

    // Expect throws
    expect(() => classMirror(_function), throwsArgumentError);
    expect(() => classMirror(_function, _library), throwsArgumentError);

    expect(() => classMirror(_notFound), throwsArgumentError);
    expect(() => classMirror(_notFound, _library), throwsArgumentError);
  });
  test('createAnnotation', () {
    final mirror = classMirror(_class);
    expect(mirror, isNotNull);

    final number = 5;

    final instance = createAnnotation(mirror, new Symbol(''), [number], {});
    expect(instance is A, isTrue);
    expect(instance.value, equals(number));
  });
  test('privateConstructor', () {
    final mirror = classMirror(_class);
    expect(mirror, isNotNull);

    final symbol = privateConstructor(mirror, new Symbol('_'));
    expect(symbol, isNotNull);

    final instance = createAnnotation(mirror, symbol, [], {});
    expect(instance, isNotNull);
    expect(instance is A, isTrue);
    expect(instance.value, equals(A.defaultValue));
  });
}
