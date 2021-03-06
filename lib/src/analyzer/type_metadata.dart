// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/dart/element/type.dart';
//import 'package:dogma_union_type/union_type.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_metadata.src.analyzer.type_metadata');

/// Creates a list of type metadata from the given [types].
List<TypeMetadata> typeMetadataList(List<DartType> types) =>
    types.map<TypeMetadata>((value) => typeMetadata(value)).toList();

/// Creates type metadata from the given [type].
TypeMetadata typeMetadata(DartType type) {
  if (type is InterfaceType) {
    return _interfaceTypeMetadata(type);
  } else if (type is TypeParameterType) {
    return _parameterizedTypeMetadata(type);
  } else if (type is FunctionType) {
    return _functionTypeMetadata(type);
  } else if (type is DynamicTypeImpl) {
    return dynamicType;
  } else if (type is VoidType) {
    return voidType;
  }

  assert(false);
  return null;
}

InterfaceTypeMetadata _interfaceTypeMetadata(InterfaceType type) {
  // Get type arguments
  final typeArguments = type.typeArguments.map<TypeMetadata>(
      (value) => typeMetadata(value)
  ).toList();

  return new InterfaceTypeMetadata(type.name, typeArguments);
}

ParameterizedTypeMetadata _parameterizedTypeMetadata(TypeParameterType type) {
  // Resolve the bound which will have extends if present
  final bound = type.resolveToBound(type);

  // If extends isn't present then the function will return the value passed in
  //
  // This check prevents infinite recursion
  final extending = bound != type ? typeMetadata(bound) : null;

  return new ParameterizedTypeMetadata(type.name, extending);
}

FunctionTypeMetadata _functionTypeMetadata(FunctionType type) {
  // Return type
  final returnType = typeMetadata(type.returnType);

  // Required and positional parameters
  final parameterTypes = _typeMetadataList(type.normalParameterTypes);
  final optionalParameterTypes = _typeMetadataList(type.optionalParameterTypes);

  // Named parameters
  final namedParameterTypes = <String, TypeMetadata>{};

  type.namedParameterTypes.forEach((key, value) {
    namedParameterTypes[key] = typeMetadata(value);
  });

  // Generic type arguments
  final typeArguments = _typeMetadataList(type.typeFormals.map<DartType>(
      (value) => value.type
  ));

  return new FunctionTypeMetadata(
      returnType,
      parameterTypes,
      optionalParameterTypes,
      namedParameterTypes,
      typeArguments
  );
}

List<T> _typeMetadataList<T extends TypeMetadata>(Iterable<DartType> types) =>
    types.map<T>(
        (value) => typeMetadata(value)
    ).toList();
