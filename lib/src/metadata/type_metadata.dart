// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/*
const String _bool = 'bool';
const String _int = 'int';
const String _num = 'num';
const String _double = 'double';
const String _string = 'String';
const String _list = 'List';
const String _map = 'Map';
const String _null = 'Null';
const String _dynamic = 'dynamic';
const String _nullableType = '';

/// Contains metadata for a type.
///
/// Information such as interfaces, base class, and mixin is not present in the
/// metadata as Dogma data only handles Plain Old Dart Objects which do not
/// have inheritance.
class TypeMetadata extends Metadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The type union.
  ///
  /// The current Dart language specification does not specify a way to specify
  /// union types. While there is no open DEP for union types at this time the
  /// Non-Null By Default (NNBD) DEP is being worked upon. With NNBD nullable
  /// types can be expressed as the union of the type and Null this can still
  /// be represented.
  final List<TypeMetadata> union = <TypeMetadata>[];

  /// The type arguments.
  ///
  /// This is only present on generic types.
  final List<TypeMetadata> arguments;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [TypeMetadata] with the given [name].
  ///
  /// If the type is generic then [arguments] should be used to fully type the
  /// metadata.
  TypeMetadata(String name, {List<TypeMetadata> arguments})
      : this._(name, arguments ?? <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a boolean.
  TypeMetadata.bool()
      : this._(_bool, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing an integer.
  TypeMetadata.int()
      : this._(_int, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a double.
  TypeMetadata.double()
      : this._(_double, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a number.
  TypeMetadata.num()
      : this._(_num, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a string.
  TypeMetadata.string()
      : this._(_string, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a dynamic type.
  TypeMetadata.dynamic()
      : this._(_dynamic, <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a list.
  ///
  /// A type [argument] can be provided for additional type information.
  TypeMetadata.list([TypeMetadata argument])
      : this._(_list, argument != null ? <TypeMetadata>[argument] : <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata] representing a map.
  ///
  /// The [key] type and [value] type can be provided for additional type
  /// information.
  factory TypeMetadata.map([TypeMetadata key, TypeMetadata value]) {
    final arguments = <TypeMetadata>[];

    // Add type arguments only if key is not null
    if (key != null) {
      arguments.add(key);

      if (value != null) {
        arguments.add(value);
      }
    }

    return new TypeMetadata._(_map, arguments);
  }

  /// Creates an instance of [TypeMetadata] from the runtime type of [value].
  TypeMetadata.runtimeType(dynamic value)
      : this._(value.runtimeType.toString(), <TypeMetadata>[]);

  /// Creates an instance of [TypeMetadata].
  TypeMetadata._(String name, this.arguments)
      : super(name);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the type is an integer.
  bool get isInt => name == _int;
  /// Whether the type is a double.
  bool get isDouble => name == _double;
  /// Whether the type is a number.
  bool get isNum => isInt || isDouble || name == _num;
  /// Whether the type is a boolean.
  bool get isBool => name == _bool;
  /// Whether the type is a string.
  bool get isString => name == _string;
  /// Whether the type is a list.
  bool get isList => name == _list;
  /// Whether the type is a map.
  bool get isMap => name == _map;
  /// Whether the type is dynamic.
  bool get isDynamic => name == _dynamic;

  /// Whether the type is built in.
  ///
  /// Builtin refers to the base types present in dart:core that can be
  /// (de)serialized directly in a JSON payload without conversion. This is
  /// done recursively for generic types.
  bool get isBuiltin {
    var value;

    // Check for lists and maps as the type arguments need to be checked
    if (isList || isMap) {
      value = true;

      for (var argument in arguments) {
        if (!argument.isBuiltin) {
          value = false;
          break;
        }
      }
    } else {
      value = isNum || isBool || isString;
    }

    return value;
  }

  //---------------------------------------------------------------------
  // Operators
  //---------------------------------------------------------------------

  @override
  bool operator== (Object compare) {
    if (identical(this, compare)) {
      return true;
    } else if (compare is TypeMetadata) {
      return name == compare.name;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + arguments.hashCode;
    return result;
  }
}

/// An instance of [TypeMetadata] representing a dynamic type.
final TypeMetadata dynamicType = new TypeMetadata.dynamic();

/// An instance of [TypeMetadata] representing an integer type.
final TypeMetadata intType = new TypeMetadata.int();
*/

class TypeMetadata implements Metadata {
  @override
  final String name;

  const TypeMetadata._(this.name);
}

class InterfaceTypeMetadata extends TypeMetadata {
  /// The type arguments.
  ///
  /// This is only present on generic types.
  final List<TypeMetadata> typeArguments;

  const InterfaceTypeMetadata(String name, [this.typeArguments = const <TypeMetadata>[]])
      : super._(name);

  @override
  bool operator== (Object compare) {
    if (identical(this, compare)) {
      return true;
    } else if (compare is TypeMetadata) {
      return name == compare.name;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + typeArguments.hashCode;
    return result;
  }
}

class ParameterizedTypeMetadata extends TypeMetadata {
  final InterfaceTypeMetadata extending;

  const ParameterizedTypeMetadata(String name, [this.extending])
      : super._(name);
}

class FunctionTypeMetadata extends TypeMetadata {
  final TypeMetadata returnType;
  final List<TypeMetadata> parameters;
  final List<TypeMetadata> typeParameters;

  const FunctionTypeMetadata(this.returnType, this.parameters, this.typeParameters)
     : super._('');
}

InterfaceTypeMetadata type(String name, [List<TypeMetadata> arguments]) =>
    new InterfaceTypeMetadata(name, arguments ?? <TypeMetadata>[]);

const InterfaceTypeMetadata boolType = const InterfaceTypeMetadata('bool');

const InterfaceTypeMetadata numType = const InterfaceTypeMetadata('num');

const InterfaceTypeMetadata intType = const InterfaceTypeMetadata('int');

const InterfaceTypeMetadata doubleType = const InterfaceTypeMetadata('double');

const InterfaceTypeMetadata stringType = const InterfaceTypeMetadata('String');

const InterfaceTypeMetadata dynamicType = const InterfaceTypeMetadata('dynamic');

const InterfaceTypeMetadata objectType = const InterfaceTypeMetadata('Object');

const InterfaceTypeMetadata nullType = const InterfaceTypeMetadata('Null');

const InterfaceTypeMetadata voidType = const InterfaceTypeMetadata('void');

const InterfaceTypeMetadata functionType = const InterfaceTypeMetadata('Function');

/// Creates an instance of [InterfaceTypeMetadata] representing a list.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `List<dynamic>`.
InterfaceTypeMetadata listType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('List', _defaultArgumentList(argument));

InterfaceTypeMetadata mapType({TypeMetadata key, TypeMetadata value}) {
  key ??= dynamicType;
  value ??= dynamicType;

  return new InterfaceTypeMetadata('Map', <TypeMetadata>[key, value]);
}

InterfaceTypeMetadata futureType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('Future', _defaultArgumentList(argument));

List<TypeMetadata> _defaultArgumentList(TypeMetadata argument) =>
    <TypeMetadata>[argument ?? dynamicType];
