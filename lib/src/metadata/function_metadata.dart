// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'annotated_metadata.dart';
import 'parameter_metadata.dart';
import 'privacy_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a function.
class FunctionMetadata extends AnnotatedMetadata with PrivacyMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The return type of the function.
  final TypeMetadata returnType;
  /// The list of parameters for the function.
  final List<ParameterMetadata> parameters;
  @override
  final bool isPrivate;

  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [FunctionMetadata] with the given [name] and
  /// [returnType].
  FunctionMetadata(String name,
                   this.returnType,
                  {List<ParameterMetadata> parameters,
                   bool isPrivate,
                   List annotations,
                   String comments})
      : parameters = parameters ?? <ParameterMetadata>[]
      , isPrivate = isPrivate ?? false
      , super(name, annotations, comments);
}
