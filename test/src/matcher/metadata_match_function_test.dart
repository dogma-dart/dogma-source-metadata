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

MetadataMatchFunction _true = (_) => true;
MetadataMatchFunction _false = (_) => false;
class _CallCount {
  bool returnValue = true;
  int count = 0;

  void resetCount() { count = 0; }

  bool call(Metadata metadata) {
    ++count;

    return returnValue;
  }

  static List<MetadataMatchFunction> repeat(_CallCount functor, int count) {
    final functions = <MetadataMatchFunction>[];

    for (var i = 0; i < count; ++i) {
      functions.add(functor);
    }

    return functions;
  }
}

Metadata _metadata = new Metadata('Test');
const int _count = 20;

/// Test entry point.
void main() {
  test('and', () {
    expect(and(_true, _true)(_metadata), isTrue);
    expect(and(_true, _false)(_metadata), isFalse);
    expect(and(_false, _true)(_metadata), isFalse);
    expect(and(_false, _false)(_metadata), isFalse);
  });
  test('or', () {
    expect(or(_true, _true)(_metadata), isTrue);
    expect(or(_true, _false)(_metadata), isTrue);
    expect(or(_false, _true)(_metadata), isTrue);
    expect(or(_false, _false)(_metadata), isFalse);
  });
  test('not', () {
    expect(not(_true)(_metadata), isFalse);
    expect(not(not(_true))(_metadata), isTrue);
    expect(not(_false)(_metadata), isTrue);
    expect(not(not(_false))(_metadata), isFalse);
  });
  test('andList', () {
    final trueFunctor = new _CallCount();
    final trueList = _CallCount.repeat(trueFunctor, _count);

    expect(andList(trueList)(_metadata), isTrue);
    expect(trueFunctor.count, equals(_count));

    final falseFunctor = new _CallCount();
    falseFunctor.returnValue = false;
    final falseList = _CallCount.repeat(falseFunctor, _count);

    expect(andList(falseList)(_metadata), isFalse);
    expect(falseFunctor.count, equals(1));

    // List of true then false
    trueFunctor.resetCount();
    falseFunctor.resetCount();
    final trueFalseList = <MetadataMatchFunction>[]
        ..addAll(trueList)
        ..addAll(falseList);

    expect(andList(trueFalseList)(_metadata), isFalse);
    expect(trueFunctor.count, equals(_count));
    expect(falseFunctor.count, equals(1));

    // List of false then true
    trueFunctor.resetCount();
    falseFunctor.resetCount();
    final falseTrueList = <MetadataMatchFunction>[]
        ..addAll(falseList)
        ..addAll(trueList);

    expect(andList(falseTrueList)(_metadata), isFalse);
    expect(trueFunctor.count, equals(0));
    expect(falseFunctor.count, equals(1));
  });
  test('orList', () {
    final trueFunctor = new _CallCount();
    final trueList = _CallCount.repeat(trueFunctor, _count);

    expect(orList(trueList)(_metadata), isTrue);
    expect(trueFunctor.count, equals(1));

    final falseFunctor = new _CallCount();
    falseFunctor.returnValue = false;
    final falseList = _CallCount.repeat(falseFunctor, _count);

    expect(orList(falseList)(_metadata), isFalse);
    expect(falseFunctor.count, equals(_count));

    // List of true then false
    trueFunctor.resetCount();
    falseFunctor.resetCount();
    final trueFalseList = <MetadataMatchFunction>[]
        ..addAll(trueList)
        ..addAll(falseList);

    expect(orList(trueFalseList)(_metadata), isTrue);
    expect(trueFunctor.count, equals(1));
    expect(falseFunctor.count, equals(0));

    // List of false then true
    trueFunctor.resetCount();
    falseFunctor.resetCount();
    final falseTrueList = <MetadataMatchFunction>[]
        ..addAll(falseList)
        ..addAll(trueList);

    expect(orList(falseTrueList)(_metadata), isTrue);
    expect(trueFunctor.count, equals(1));
    expect(falseFunctor.count, equals(_count));
  });
}
