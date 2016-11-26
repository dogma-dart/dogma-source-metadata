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

/// The base class for all type metadata.
class TypeMetadata implements Metadata {
  @override
  final String name;

  const TypeMetadata._(this.name);
}

/// Represents a concrete interface type.
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

  /// Creates an [InterfaceTypeMetadata] with the given [name].
  ///
  /// Additionally [typeArguments] can be provided for generic types.
  const InterfaceTypeMetadata(String name,
                              this.typeArguments)
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

/// Represents a generic type.
class ParameterizedTypeMetadata extends TypeMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The type the value is extending.
  final InterfaceTypeMetadata extending;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [ParameterizedTypeMetadata].
  ///
  /// The [name] is the reference. The value of [extending] corresponds to the
  /// base class the generic is extending from.
  const ParameterizedTypeMetadata(String name, this.extending)
      : super._(name);

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  bool operator== (Object compare) {
    if (identical(this, compare)) {
      return true;
    } else if (compare is ParameterizedTypeMetadata) {
      return (name == compare.name) && (extending == compare.extending);
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + name.hashCode;
    if (extending != null) {
      result = 37 * result + extending.hashCode;
    }
    return result;
  }

  @override
  String toString() {
    final extension = extending != null ? ' extends $extending' : '';

    return name + extension;
  }
}

/// Represents a function type.
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
  final List<TypeMetadata> typeArguments;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [FunctionTypeMetadata].
  ///
  /// The [returnType] specifies the type returned by the function. The
  /// [parameterTypes] refer to required parameters. The
  /// [optionalParameterTypes] refers to optional parameters. The
  /// [namedParameterTypes] is a map of parameter names and types. The
  /// [typeArguments] are for generics.
  const FunctionTypeMetadata(this.returnType,
                             this.parameterTypes,
                             this.optionalParameterTypes,
                             this.namedParameterTypes,
                             this.typeArguments)
     : super._('');

  //---------------------------------------------------------------------
  // Object
  //---------------------------------------------------------------------

  @override
  bool operator== (Object compare) {
    if (identical(this, compare)) {
      return true;
    } else if (compare is FunctionTypeMetadata) {
      return
          (returnType == compare.returnType) &&
          _typeListEqual(parameterTypes, compare.parameterTypes) &&
          _typeListEqual(optionalParameterTypes, compare.optionalParameterTypes) &&
          _typeMapEqual(namedParameterTypes, compare.namedParameterTypes) &&
          _typeListEqual(typeArguments, compare.typeArguments);
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + returnType.hashCode;
    result = 37 * result + parameterTypes.hashCode;
    result = 37 * result + optionalParameterTypes.hashCode;
    result = 37 * result + namedParameterTypes.hashCode;
    result = 37 * result + typeArguments.hashCode;
    return result;
  }

  @override
  String toString() {
    final parameterList = <String>[];
    var genericString = '';

    if (parameterTypes.isNotEmpty) {
      parameterList.add(parameterTypes.join(','));
    }

    if (optionalParameterTypes.isNotEmpty) {
      parameterList.add('[${optionalParameterTypes.join(',')}');
    }

    if (namedParameterTypes.isNotEmpty) {
      parameterList.add('{${namedParameterTypes.values.join(',')}');
    }

    if (typeArguments.isNotEmpty) {
      genericString = '<${typeArguments.join(',')}>';
    }

    return '(${parameterList.join(',')})$genericString -> $returnType';
  }

  //---------------------------------------------------------------------
  // Private class methods
  //---------------------------------------------------------------------

  /// Checks if the two lists for types, [a] and [b], are equal.
  static bool _typeListEqual(List<TypeMetadata> a, List<TypeMetadata> b) {
    final aCount = a.length;

    if (aCount != b.length) {
      return false;
    }

    for (var i = 0; i < aCount; ++i) {
      if (a[i] != b[i]) {
        return false;
      }
    }

    return true;
  }

  /// Checks if two maps for types, [a] and [b], are equal.
  static bool _typeMapEqual(Map<String, TypeMetadata> a, Map<String, TypeMetadata> b) {
    if (a.length != b.length) {
      return false;
    }

    for (var key in a.keys) {
      if (!b.containsKey(key)) {
        return false;
      }

      if (a[key] != b[key]) {
        return false;
      }
    }

    return true;
  }
}

//---------------------------------------------------------------------
// Common interface types
//---------------------------------------------------------------------

/// A boolean type.
const InterfaceTypeMetadata boolType =
    const InterfaceTypeMetadata('bool', _empty);

/// A number type.
const InterfaceTypeMetadata numType =
    const InterfaceTypeMetadata('num', _empty);

/// An integer type.
const InterfaceTypeMetadata intType =
    const InterfaceTypeMetadata('int', _empty);

/// A double type.
const InterfaceTypeMetadata doubleType =
    const InterfaceTypeMetadata('double', _empty);

/// A string type.
const InterfaceTypeMetadata stringType =
    const InterfaceTypeMetadata('String', _empty);

/// A dynamic type.
const InterfaceTypeMetadata dynamicType =
    const InterfaceTypeMetadata('dynamic', _empty);

/// An object type.
const InterfaceTypeMetadata objectType =
    const InterfaceTypeMetadata('Object', _empty);

/// A null type.
const InterfaceTypeMetadata nullType =
    const InterfaceTypeMetadata('Null', _empty);

/// A void type.
const InterfaceTypeMetadata voidType =
    const InterfaceTypeMetadata('void', _empty);

//---------------------------------------------------------------------
// Factory functions
//---------------------------------------------------------------------

/// Creates an [InterfaceTypeMetadata] with the given [name].
///
/// For generics [arguments] can be specified.
InterfaceTypeMetadata interfaceType(String name, [List<TypeMetadata> arguments]) =>
    new InterfaceTypeMetadata(name, arguments ?? <TypeMetadata>[]);

/// Creates a [ParameterizedTypeMetadata] with the given [name].
///
/// If the parameterized type has a base then specify it with [extending].
ParameterizedTypeMetadata parameterizedType(String name,
                                           [TypeMetadata extending]) =>
    new ParameterizedTypeMetadata(name, extending);

/// Creates a [FunctionTypeMetadata].
///
/// If a [returnType] is not specified then the value is [dynamicType]. If
/// [parameterTypes], [optionalParameterTypes] are not specified then the value
/// is the empty list. If [namedParameterTypes] is not specified then the value
/// is an empty map.
FunctionTypeMetadata functionType({TypeMetadata returnType,
                                   List<TypeMetadata> parameterTypes,
                                   List<TypeMetadata> optionalParameterTypes,
                                   Map<String, TypeMetadata> namedParameterTypes,
                                   List<TypeMetadata> typeArguments}) {
  returnType ??= dynamicType;
  parameterTypes ??= <TypeMetadata>[];
  optionalParameterTypes ??= <TypeMetadata>[];
  namedParameterTypes ??= <String, TypeMetadata>{};
  typeArguments ??= <TypeMetadata>[];

  return new FunctionTypeMetadata(
      returnType,
      parameterTypes,
      optionalParameterTypes,
      namedParameterTypes,
      typeArguments
  );
}

const List<TypeMetadata> _empty = const <TypeMetadata>[];
const String _listName = 'List';
const String _iterableName = 'Iterable';
const String _mapName = 'Map';
const String _futureName = 'Future';
const String _streamName = 'Stream';

/// Creates an instance of [InterfaceTypeMetadata] representing a list.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `List<dynamic>`.
InterfaceTypeMetadata listType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata(_listName, _defaultArgumentList(argument));

/// Creates an instance of [InterfaceTypeMetadata] representing an iterable.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `Iterable<dynamic>`.
InterfaceTypeMetadata iterableType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata(_iterableName, _defaultArgumentList(argument));

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
    new InterfaceTypeMetadata(_futureName, _defaultArgumentList(argument));

/// Creates an instance of [InterfaceTypeMetadata] representing a stream.
///
/// A type [argument] can be provided for additional type information. If it is
/// not specified the type is `Future<dynamic>`.
InterfaceTypeMetadata streamType([TypeMetadata argument]) =>
    new InterfaceTypeMetadata(_streamName, _defaultArgumentList(argument));

/// Creates a default argument list for a type with a single type [argument].
List<TypeMetadata> _defaultArgumentList(TypeMetadata argument) =>
    <TypeMetadata>[argument ?? dynamicType];

//---------------------------------------------------------------------
// Type checks
//---------------------------------------------------------------------

/// Checks whether the [type] is a List.
///
/// This will not verify the correctness of any generic type arguments.
bool isListType(TypeMetadata type) =>
    type is InterfaceTypeMetadata ? type.name == _listName : false;

/// Checks whether the [type] is an Iterable.
///
/// This will not verify the correctness of any generic type arguments.
bool isIterableType(TypeMetadata type) =>
    type is InterfaceTypeMetadata ? type.name == _iterableName : false;

/// Checks whether the [type] is a Map.
///
/// This will not verify the correctness of any generic type arguments.
bool isMapType(TypeMetadata type) =>
    type is InterfaceTypeMetadata ? type.name == _mapName : false;

/// Checks whether the [type] is a Future.
///
/// This will not verify the correctness of any generic type arguments.
bool isFutureType(TypeMetadata type) =>
    type is InterfaceTypeMetadata ? type.name == _futureName : false;

/// Checks whether the [type] is a Stream.
///
/// This will not verify the correctness of any generic type arguments.
bool isStreamType(TypeMetadata type) =>
    type is InterfaceTypeMetadata ? type.name == _streamName : false;
