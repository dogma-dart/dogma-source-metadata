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

class TypeMetadata implements Metadata {
  @override
  final String name;

  const TypeMetadata._(this.name);
}

class InterfaceTypeMetadata extends TypeMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The type arguments.
  ///
  /// This is only present on generic types.
  final List<TypeMetadata> typeArguments;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  const InterfaceTypeMetadata(String name, [this.typeArguments = const <TypeMetadata>[]])
      : super._(name);

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  bool operator== (Object compare) {
    if (identical(this, compare)) {
      return true;
    } else if (compare is InterfaceTypeMetadata) {
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

  @override
  String toString() {
    return name;
  }
}

class ParameterizedTypeMetadata extends TypeMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final InterfaceTypeMetadata extending;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  const ParameterizedTypeMetadata(String name, [this.extending])
      : super._(name);

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  String toString() {
    final extension = extending != null ? ' extends $extending' : '';

    return name + extension;
  }
}

class FunctionTypeMetadata extends TypeMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The return type of the function.
  final TypeMetadata returnType;
  /// The types for the required parameters of the function.
  final List<TypeMetadata> parameterTypes;
  /// The types for the optional parameters of the function.
  final List<TypeMetadata> optionalParameterTypes;
  /// The name and types for the named parameters of the function.
  final Map<String, TypeMetadata> namedParameterTypes;
  /// The type arguments for the function.
  final List<TypeMetadata> typeParameters;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  const FunctionTypeMetadata({this.returnType: dynamicType,
                              this.parameterTypes: const <TypeMetadata>[],
                              this.optionalParameterTypes: const <TypeMetadata>[],
                              this.namedParameterTypes: const <String, TypeMetadata>{},
                              this.typeParameters: const <TypeMetadata>[]})
     : super._('');

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  String toString() {
    return '() -> $returnType';
  }
}

InterfaceTypeMetadata interfaceType(String name, [List<TypeMetadata> arguments]) =>
    new InterfaceTypeMetadata(name, arguments ?? <TypeMetadata>[]);

ParameterizedTypeMetadata parameterizedType(String name,
                                           [TypeMetadata extending]) =>
    new ParameterizedTypeMetadata(name, extending);

FunctionTypeMetadata functionType() => new FunctionTypeMetadata();

/// A boolean type.
const InterfaceTypeMetadata boolType = const InterfaceTypeMetadata('bool');

/// A number type.
const InterfaceTypeMetadata numType = const InterfaceTypeMetadata('num');

/// An integer type.
const InterfaceTypeMetadata intType = const InterfaceTypeMetadata('int');

/// A double type.
const InterfaceTypeMetadata doubleType = const InterfaceTypeMetadata('double');

/// A string type.
const InterfaceTypeMetadata stringType = const InterfaceTypeMetadata('String');

/// A dynamic type.
const InterfaceTypeMetadata dynamicType = const InterfaceTypeMetadata('dynamic');

/// An object type.
const InterfaceTypeMetadata objectType = const InterfaceTypeMetadata('Object');

/// A null type.
const InterfaceTypeMetadata nullType = const InterfaceTypeMetadata('Null');

/// A void type.
const InterfaceTypeMetadata voidType = const InterfaceTypeMetadata('void');

/// Creates an instance of [InterfaceTypeMetadata] representing a list.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `List<dynamic>`.
InterfaceTypeMetadata listType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('List', _defaultArgumentList(argument));

/// Creates an instance of [InterfaceTypeMetadata] representing an iterable.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `Iterable<dynamic>`.
InterfaceTypeMetadata iterableType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('Iterable', _defaultArgumentList(argument));

/// Creates an instance of [InterfaceTypeMetadata] representing a map.
///
/// A type for the [key] and/or [value] can be provided for addition type
/// information. If it is not specified the key and value type arguments
/// default to [dynamicType].
InterfaceTypeMetadata mapType({TypeMetadata key, TypeMetadata value}) {
  key ??= dynamicType;
  value ??= dynamicType;

  return new InterfaceTypeMetadata('Map', <TypeMetadata>[key, value]);
}

/// Creates an instance of [InterfaceTypeMetadata] representing a future.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `Future<dynamic>`.
InterfaceTypeMetadata futureType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('Future', _defaultArgumentList(argument));

/// Creates an instance of [InterfaceTypeMetadata] representing a stream.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `Future<dynamic>`.
InterfaceTypeMetadata streamType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata('Stream', _defaultArgumentList(argument));

///
/// Creates a default argument list for a type with a single type [argument].
List<TypeMetadata> _defaultArgumentList(TypeMetadata argument) =>
    <TypeMetadata>[argument ?? dynamicType];
