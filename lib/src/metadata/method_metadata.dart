// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'abstract_metadata.dart';
import 'function_metadata.dart';
import 'parameter_metadata.dart';
import 'static_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a method.
class MethodMetadata extends FunctionMetadata
                  implements AbstractMetadata,
                             StaticMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final bool isAbstract;
  @override
  final bool isStatic;

  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [MethodMetadata] with the given [name] and
  /// [returnType].
  MethodMetadata(String name,
                {TypeMetadata returnType,
                 List<ParameterMetadata> parameters,
                 this.isAbstract: false,
                 this.isStatic: false,
                 List annotations,
                 String comments})
      : super(name,
              returnType: returnType,
              parameters: parameters,
              annotations: annotations,
              comments: comments);
}
