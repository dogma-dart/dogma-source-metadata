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

/// Contains metadata for a function typedef.
class TypedefMetadata extends FunctionMetadata {
  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [TypedefMetadata] with the given [name].
  TypedefMetadata(String name,
                 {TypeMetadata returnType,
                  List<ParameterMetadata> parameters,
                  List<TypeMetadata> typeParameters,
                  List annotations,
                  String comments})
      : super(name,
              returnType: returnType,
              parameters: parameters,
              typeParameters: typeParameters,
              annotations: annotations,
              comments: comments);
}
