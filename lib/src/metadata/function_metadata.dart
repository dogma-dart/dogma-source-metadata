// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'annotated_metadata.dart';
import 'enclosing_metadata.dart';
import 'generic_metadata.dart';
import 'parameter_kind.dart';
import 'parameter_metadata.dart';
import 'privacy_metadata.dart';
import 'type_metadata.dart';
import 'typed_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a function.
class FunctionMetadata extends AnnotatedMetadata
                          with PrivacyMetadata,
                               EnclosedMetadata,
                               EnclosingMetadata
                    implements GenericMetadata,
                               TypedMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The return type of the function.
  final TypeMetadata returnType;
  /// The list of parameters for the function.
  final List<ParameterMetadata> parameters;
  @override
  final List<TypeMetadata> typeParameters;
  /// The type of the metadata.
  FunctionTypeMetadata _type;

  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [FunctionMetadata] with the given [name] and
  /// [returnType].
  FunctionMetadata(String name,
                  {TypeMetadata returnType,
                   List<ParameterMetadata> parameters,
                   List<TypeMetadata> typeParameters,
                   List annotations,
                   String comments})
      : returnType = returnType ?? dynamicType
      , parameters = parameters ?? <ParameterMetadata>[]
      , typeParameters = typeParameters ?? <TypeMetadata>[]
      , super(name, annotations, comments)
  {
    // Use `this` to properly scope the value
    encloseList(this.parameters);
    // Compute the type
    _determineType();
  }

  //---------------------------------------------------------------------
  // TypedMetadata
  //---------------------------------------------------------------------

  @override
  TypeMetadata get type => _type;

  /// Determine the type for the metadata.
  void _determineType() {
    // Get the function declaration types
    final parameterTypes = <TypeMetadata>[];
    final optionalParameterTypes = <TypeMetadata>[];
    final namedParameterTypes = <String, TypeMetadata>{};

    for (var parameter in parameters) {
      final kind = parameter.parameterKind;
      final type = parameter.type;

      if (kind == ParameterKind.required) {
        parameterTypes.add(type);
      } else if (kind == ParameterKind.positional) {
        optionalParameterTypes.add(type);
      } else {
        namedParameterTypes[parameter.name] = type;
      }
    }

    _type = new FunctionTypeMetadata(
        returnType,
        parameterTypes,
        optionalParameterTypes,
        namedParameterTypes,
        typeParameters
    );
  }
}
