// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'metadata_builder.dart';
import 'constant_metadata_builder.dart';
import 'function_metadata_builder.dart';
import 'validate_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [ConstructorMetadata].
class ConstructorMetadataBuilder extends FunctionMetadataBuilder
                                    with ConstantMetadataBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the constructor is a factory constructor.
  bool isFactory = false;

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    // Do not call super.validate() as it contains name validation which will
    // fail for default constructors

    // Perform the same validation as FunctionMetadataBuilder
    validateUniqueNames(parameters);
    validateParameterPositions();
    validateOptionalNamedParameters();

    // Only perform the initializer check when creating a factory constructor
    if (isFactory) {
      validateNoInitializers();
    }
  }

  @override
  ConstructorMetadata buildInternal() =>
      new ConstructorMetadata(
          returnType,
          name: name,
          parameters: buildList/*<ParameterMetadata>*/(parameters),
          isConst: isConst,
          isFactory: isFactory,
          annotations: annotations,
          comments: comments
      );
}

/// Creates an instance of [ConstructorMetadata] that represents a default
/// constructor.
ConstructorMetadataBuilder defaultConstructor() =>
    new ConstructorMetadataBuilder();

/// Creates an instance of [ConstructorMetadata] with the given [name]d
/// constructor.
ConstructorMetadataBuilder constructor(String name) =>
    new ConstructorMetadataBuilder()
        ..name = name;
