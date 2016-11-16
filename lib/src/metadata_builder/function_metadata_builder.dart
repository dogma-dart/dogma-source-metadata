// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:meta/meta.dart';

import '../../metadata.dart';
import 'generic_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'parameter_metadata_builder.dart';
import 'typed_metadata_builder.dart';
import 'validate_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [FunctionMetadata].
///
/// The [FunctionMetadataBuilder] does the following validations.
///
/// * The function must have a name.
/// * Parameter names must be unique.
/// * Optional and named parameters must follow required parameters.
/// * Optional and named parameters cannot be used in the same function.
/// * Initializers are not valid for function calls.
class FunctionMetadataBuilder extends MetadataBuilder<FunctionMetadata>
                                 with GenericMetadataBuilder,
                                      TypedMetadataBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The return type of the function.
  TypeMetadata returnType = dynamicType;
  /// The list of parameters for the function.
  List<ParameterMetadataBuilder> parameters = <ParameterMetadataBuilder>[];

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

    validateUniqueNames(parameters);
    validateParameterPositions();
    validateOptionalNamedParameters();
    validateNoInitializers();
  }

  @override
  FunctionMetadata buildInternal() =>
      new FunctionMetadata(
        name,
        returnType: returnType,
        parameters: buildList/*<ParameterMetadata>*/(parameters),
        typeParameters: typeParameters,
        annotations: annotations,
        comments: comments
      );

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  /// Validates that required parameters are before positional and named
  /// parameters.
  @protected
  void validateParameterPositions() {
    var isOptional = false;

    for (var parameter in parameters) {
      final isRequired = parameter.parameterKind == ParameterKind.required;

      if (isOptional) {
        if (isRequired) {
          throw new InvalidMetadataError('A required parameter comes after a named or positional parameter');
        }
      } else {
        isOptional = !isRequired;
      }
    }
  }

  /// Validates that only positional or named parameters are used.
  @protected
  void validateOptionalNamedParameters() {
    final positional = parameters.firstWhere(
        (value) => value.parameterKind == ParameterKind.positional,
        orElse: () => null
    );
    final named = parameters.firstWhere(
        (value) => value.parameterKind == ParameterKind.named,
        orElse: () => null
    );

    if ((positional != null) && (named != null)) {
      throw new InvalidMetadataError('Function cannot have both named and positional parameters');
    }
  }

  /// Validates that the parameters do not contain initializers.
  ///
  /// The use of initializers is only valid with constructors.
  @protected
  void validateNoInitializers() {
    final initializer = parameters.firstWhere(
        (value) => value.isInitializer, orElse: () => null
    );

    if (initializer != null) {
      throw new InvalidMetadataError('Function cannot have parameters that initialize');
    }
  }
}

/// Creates an instance of [FunctionMetadataBuilder] with the given [name].
///
/// The builder returned is equivalent to the following function declaration.
///
///     name()
FunctionMetadataBuilder function(String name) =>
    new FunctionMetadataBuilder()
        ..name = name;
