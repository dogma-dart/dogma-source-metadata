// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/constant.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Attempts to convert the [value] into a Dart object.
///
/// This can be used to determine constant values that the analyzer can
/// instantiate properly.
dynamic dartValue(DartObjectImpl value) {
  var typeName = value.type.displayName;

  switch (typeName) {
    case 'String':
      return value.toStringValue();
    case 'Map':
      return _toMapValue(value);
    case 'List':
      return _toListValue(value);
    case 'int':
      return value.toIntValue();
    case 'double':
    case 'num':
      return value.toDoubleValue();
    case 'bool':
      return value.toBoolValue();
    case 'Type':
      return value.toTypeValue();
    case 'Symbol':
      return value.toSymbolValue();
    case 'Null':
      return null;
    default:
      assert(false);
      return null;
  }
}

/// Converts the [value] into a Dart List instance.
List _toListValue(DartObjectImpl value) =>
    value.toListValue().map((dartObject) => dartValue(dartObject)).toList();

/// Converts the [value] into a Dart Map instance.
Map _toMapValue(DartObjectImpl value) {
  var map = {};

  value.toMapValue().forEach((key, value) {
    map[dartValue(key)] = dartValue(value);
  });

  return map;
}
