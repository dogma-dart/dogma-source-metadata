// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/constant.dart';
import 'package:analyzer/dart/element/element.dart';

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

/// When [value] is an enumeration the value of its index is returned otherwise
/// `null` is returned.
dynamic dartEnumIndex(DartObject value) {
  var element = value.type.element;

  return ((element is ClassElement) && (element.isEnum))
      ? value.getField('index').toIntValue()
      : null;
}

/// When [value] is a function the name of the function is returned otherwise
/// `null` is returned.
dynamic dartFunctionName(DartObject value) {
  var element = value.type.element;

  return element is FunctionElement ? element.name : null;
}

/// Joins the functions [a] and [b] into a larger statement.
///
/// The function will call [a] first and if the result is not `null` return
/// the value. If it is `null` then the result of [b] will be returned.
///
/// Multiple functions can be joined together by calling [joinDartValue]
/// with the previous result.
///
///     joinDartValue(a, joinDartValue(b, c));
CreateDartValue joinDartValue(CreateDartValue a, CreateDartValue b) =>
    (DartObject value) => a(value) ?? b(value);

/// Default function which will just return `null` for any object.
///
/// This function should not be called for a successful query.
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
