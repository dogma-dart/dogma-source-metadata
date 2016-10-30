// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'constant_metadata.dart';
import 'function_metadata.dart';
import 'parameter_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a method.
class ConstructorMetadata extends FunctionMetadata implements ConstantMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final bool isConst;
  /// Whether the constructor is a factory constructor.
  final bool isFactory;

  //---------------------------------------------------------------------
  // Constructor
  //---------------------------------------------------------------------

  /// Creates an instance of [ConstructorMetadata] referencing a default
  /// constructor of the [returnType].
  ConstructorMetadata(TypeMetadata returnType,
                     {String name,
                      List<ParameterMetadata> parameters,
                      bool isPrivate,
                      this.isConst: false,
                      this.isFactory: false,
                      List annotations,
                      String comments})
      : super(name ?? '',
              returnType: returnType,
              parameters: parameters,
              annotations: annotations,
              comments: comments);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// Whether the constructor is the default constructor.
  bool get isDefault => name.isEmpty;
}
