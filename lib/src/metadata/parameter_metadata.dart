// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';
import 'parameter_kind.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a parameter on a function or method.
class ParameterMetadata extends Metadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The type information for the field.
  final TypeMetadata type;
  /// The kind of parameter.
  final ParameterKind parameterKind;
  /// The default value of the parameter.
  final dynamic defaultValue;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Creates an instance of [ParameterMetadata] with the given [name] and
  /// accepting the given [type].
  ///
  /// By default the [parameterKind] is set to required. If the parameter is
  /// optional then [defaultsTo] should be set unless null is desired for the
  /// default value.
  ParameterMetadata(String name,
                    this.type,
                   {this.parameterKind: ParameterKind.required,
                    this.defaultValue})
      : super(name);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the parameter is required by calling code.
  bool get isRequired => parameterKind == ParameterKind.required;
  /// Whether the parameter is optional for calling code.
  bool get isOptional => !isRequired;
}
