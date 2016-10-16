// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The maximum depth of a List or Map to create.
const int _maxDepth = 10;

/// Create a bool type.
TypeMetadata _boolType() => new TypeMetadata('bool');
/// Create an integer type.
TypeMetadata _intType() => new TypeMetadata('int');
/// Create a double type.
TypeMetadata _doubleType() => new TypeMetadata('double');
/// Create a number type.
TypeMetadata _numType() => new TypeMetadata('num');
/// Create a string type.
TypeMetadata _stringType() => new TypeMetadata('String');
/// Creates a user type.
TypeMetadata _userType() => new TypeMetadata('Foo');
/// Create a List type.
TypeMetadata _listType(TypeMetadata type, [int depth = 1]) {
  var root = new TypeMetadata('List', arguments: [type]);

  for (var i = 1; i < depth; ++i) {
    root = new TypeMetadata('List', arguments: [root]);
  }

  return root;
}
/// Create a Map type.
TypeMetadata _mapType(TypeMetadata key, TypeMetadata value, [int depth = 1]) {
  var root = new TypeMetadata('Map', arguments: [key, value]);

  for (var i = 1; i < depth; ++i) {
    root = new TypeMetadata('Map', arguments: [key, root]);
  }

  return root;
}

/// Test entry point.
void main() {
  test('bool type', () {
    final type = _boolType();

    expect(type.isInt, isFalse);
    expect(type.isDouble, isFalse);
    expect(type.isNum, isFalse);
    expect(type.isBool, isTrue);
    expect(type.isString, isFalse);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isTrue);
  });

  test('int type', () {
    final type = _intType();

    expect(type.isInt, isTrue);
    expect(type.isDouble, isFalse);
    expect(type.isNum, isTrue);
    expect(type.isBool, isFalse);
    expect(type.isString, isFalse);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isTrue);
  });

  test('double type', () {
    final type = _doubleType();

    expect(type.isInt, isFalse);
    expect(type.isDouble, isTrue);
    expect(type.isNum, isTrue);
    expect(type.isBool, isFalse);
    expect(type.isString, isFalse);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isTrue);
  });

  test('num type', () {
    final type = _numType();

    expect(type.isInt, isFalse);
    expect(type.isDouble, isFalse);
    expect(type.isNum, isTrue);
    expect(type.isBool, isFalse);
    expect(type.isString, isFalse);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isTrue);
  });

  test('String type', () {
    final type = _stringType();

    expect(type.isInt, isFalse);
    expect(type.isDouble, isFalse);
    expect(type.isNum, isFalse);
    expect(type.isBool, isFalse);
    expect(type.isString, isTrue);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isTrue);
  });

  test('User defined type', () {
    final type = _userType();

    expect(type.isInt, isFalse);
    expect(type.isDouble, isFalse);
    expect(type.isNum, isFalse);
    expect(type.isBool, isFalse);
    expect(type.isString, isFalse);
    expect(type.isList, isFalse);
    expect(type.isMap, isFalse);
    expect(type.isBuiltin, isFalse);
  });

  test('List type', () {
    final expectListType = (type, builtin) {
      expect(type.isInt, isFalse);
      expect(type.isDouble, isFalse);
      expect(type.isNum, isFalse);
      expect(type.isBool, isFalse);
      expect(type.isString, isFalse);
      expect(type.isList, isTrue);
      expect(type.isMap, isFalse);
      expect(type.isBuiltin, builtin);
    };

    final checkListWithType = (type, maxDepth, builtin) {
      for (var i = 1; i < maxDepth; ++i) {
        expectListType(_listType(type, i), builtin);
      }
    };

    checkListWithType(_boolType(), _maxDepth, isTrue);
    checkListWithType(_intType(), _maxDepth, isTrue);
    checkListWithType(_doubleType(), _maxDepth, isTrue);
    checkListWithType(_numType(), _maxDepth, isTrue);
    checkListWithType(_stringType(), _maxDepth, isTrue);
    checkListWithType(_userType(), _maxDepth, isFalse);
  });

  test('Map type', () {
    final expectMapType = (type, builtin) {
      expect(type.isInt, isFalse);
      expect(type.isDouble, isFalse);
      expect(type.isNum, isFalse);
      expect(type.isBool, isFalse);
      expect(type.isString, isFalse);
      expect(type.isList, isFalse);
      expect(type.isMap, isTrue);
      expect(type.isBuiltin, builtin);
    };

    final checkMapWithType = (type, maxDepth, builtin) {
      for (var i = 1; i < maxDepth; ++i) {
        expectMapType(_mapType(_stringType(), type, i), builtin);
      }
    };

    checkMapWithType(_boolType(), _maxDepth, isTrue);
    checkMapWithType(_intType(), _maxDepth, isTrue);
    checkMapWithType(_doubleType(), _maxDepth, isTrue);
    checkMapWithType(_numType(), _maxDepth, isTrue);
    checkMapWithType(_stringType(), _maxDepth, isTrue);
    checkMapWithType(_userType(), _maxDepth, isFalse);
  });
}
