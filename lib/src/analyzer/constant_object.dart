// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/constant.dart';
import 'package:analyzer/src/generated/element.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A function that instantiates an instance of a dart object from the given
/// [value].
///
///
typedef dynamic CreateDartValue(DartObject value);

/// Attempts to convert the [value] into a Dart object.
///
/// This can be used to determine constant values that the analyzer can
/// instantiate properly.
dynamic dartValue(DartObject value,
                 [CreateDartValue valueCreator]) {
  // No creator was supplied so use the _unknownDartValue function
  valueCreator ??= _unknownDartValue;

  var typeName = value.type.displayName;

  switch (typeName) {
    case 'String':
      return value.toStringValue();
    case 'Map':
      return _toMapValue(value, valueCreator);
    case 'List':
      return _toListValue(value, valueCreator);
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
      return valueCreator(value);
  }
}

dynamic dartEnumIndex(DartObject value) {
  var element = value.type.element;

  return ((element is ClassElement) && (element.isEnum))
      ? value.getField('index').toIntValue()
      : null;
}

dynamic dartFunctionName(DartObject value) {
  var element = value.type.element;

  return element is FunctionElement ? element.name : null;
}

CreateDartValue joinDartValue(CreateDartValue a, CreateDartValue b) =>
    (DartObject value) => a(value) ?? b(value);

dynamic _unknownDartValue(DartObject _) {
  assert(false);
  return null;
}

/// Converts the [value] into a Dart List instance.
List _toListValue(DartObjectImpl value, CreateDartValue valueCreator) =>
    value.toListValue().map(
        (dartObject) => dartValue(dartObject, valueCreator)
    ).toList();

/// Converts the [value] into a Dart Map instance.
Map _toMapValue(DartObjectImpl value, CreateDartValue valueCreator) {
  var map = {};

  value.toMapValue().forEach((key, value) {
    map[dartValue(key)] = dartValue(value, valueCreator);
  });

  return map;
}
