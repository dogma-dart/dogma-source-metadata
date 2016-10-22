// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'typed_metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [ParameterMetadata].
///
/// The [ParameterMetadataBuilder] does the following validations.
///
/// * The parameter must have a name.
/// * A default value is not valid for a required parameter.
class ParameterMetadataBuilder extends MetadataBuilder<ParameterMetadata>
                                  with TypedMetadataBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The kind of parameter.
  ParameterKind parameterKind = ParameterKind.required;
  /// Whether the parameter is an initializer.
  ///
  /// This should only be in constructors and signifies when `this.value` is
  /// used.
  bool isInitializer = false;
  /// The default value of the parameter.
  dynamic defaultValue;

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

    if ((defaultValue != null) && (parameterKind == ParameterKind.required)) {
      throw new InvalidMetadataError('A required parameter has no default value');
    }
  }

  @override
  ParameterMetadata buildInternal() =>
      new ParameterMetadata(
          name,
          type: type,
          parameterKind: parameterKind,
          isInitializer: isInitializer,
          defaultValue: defaultValue,
          annotations: annotations
      );
}

/// Creates an instance of [ParameterMetadataBuilder] with the given [name]
/// which represents a required parameter.
///
/// After calling the value in the builder is equivalent to the following
/// parameter declaration.
///
///     void func(name)
ParameterMetadataBuilder parameter(String name) =>
    new ParameterMetadataBuilder()
        ..name = name;

/// Creates an instance of [ParameterMetadataBuilder] with the given [name]
/// which represents a positional parameter.
///
/// After calling the value in the builder is equivalent to the following
/// parameter declaration.
///
///     void func([name])
ParameterMetadataBuilder positionalParameter(String name) =>
    parameter(name)
        ..parameterKind = ParameterKind.positional;

/// Creates an instance of [ParameterMetadataBuilder] with the given [name]
/// which represents a named parameter.
///
/// After calling the value in the builder is equivalent to the following
/// parameter declaration.
///
///     void func({name})
ParameterMetadataBuilder namedParameter(String name) =>
    parameter(name)
        ..parameterKind = ParameterKind.named;
