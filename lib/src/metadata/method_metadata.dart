// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'function_metadata.dart';
import 'parameter_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a method.
class MethodMetadata extends FunctionMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the method is a class method.
  final bool isStatic;

  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [MethodMetadata] with the given [name] and
  /// [returnType].
  MethodMetadata(String name,
                 TypeMetadata returnType,
                {List<ParameterMetadata> parameters,
                 bool isPrivate,
                 this.isStatic: false,
                 List annotations,
                 String comments})
      : super(name,
              returnType,
              parameters: parameters,
              isPrivate: isPrivate,
              annotations: annotations,
              comments: comments);
}
