// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'abstract_metadata_builder.dart';
import 'function_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'static_metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [MethodMetadata].
class MethodMetadataBuilder extends FunctionMetadataBuilder
                               with AbstractMetadataBuilder,
                                    StaticMetadataBuilder {
  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

    if (isStatic && isAbstract) {
      throw new InvalidMetadataError('Method $name cannot be static and abstract');
    }
  }

  @override
  MethodMetadata buildInternal() =>
      new MethodMetadata(
          name,
          returnType: returnType,
          parameters: buildList/*<ParameterMetadata>*/(parameters),
          isAbstract: isAbstract,
          isStatic: isStatic,
          annotations: annotations,
          comments: comments
      );
}

/// Creates an instance of [MethodMetadataBuilder] with the given [name].
MethodMetadataBuilder method(String name) =>
    new MethodMetadataBuilder()
        ..name = name;

/// Creates an instance of [MethodMetadataBuilder] with the given [name] where
/// the method is a static class method.
MethodMetadataBuilder staticMethod(String name) =>
    method(name)
        ..isStatic = true;
