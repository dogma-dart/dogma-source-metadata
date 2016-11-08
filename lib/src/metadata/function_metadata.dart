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
import 'parameter_metadata.dart';
import 'privacy_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a function.
class FunctionMetadata extends AnnotatedMetadata
                          with PrivacyMetadata,
                               EnclosedMetadata,
                               EnclosingMetadata
                    implements GenericMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The return type of the function.
  final TypeMetadata returnType;
  /// The list of parameters for the function.
  final List<ParameterMetadata> parameters;
  @override
  final List<TypeMetadata> typeParameters;

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
  }
}
