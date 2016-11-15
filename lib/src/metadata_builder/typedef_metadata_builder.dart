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

/// A [MetadataBuilder] for [TypedefMetadata].
class TypedefMetadataBuilder extends FunctionMetadataBuilder {
  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  TypedefMetadata buildInternal() =>
      new TypedefMetadata(
          name,
          returnType: returnType,
          parameters: buildList/*<ParameterMetadata>*/(parameters),
          annotations: annotations,
          comments: comments
      );
}
