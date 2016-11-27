// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata/metadata_builder.dart';

import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

expectThrowsOnRepeatedNames(FunctionMetadataBuilder builder) => () {
  builder
      ..parameters = [
        parameter('foo'),
        parameter('foo')
      ];

  expectThrowsInvalidMetadataError(builder);
};

expectThrowsOnInvalidPosition(FunctionMetadataBuilder builder) => () {
  builder
      ..parameters = [
        parameter('_0'),
        positionalParameter('_1'),
        parameter('_2')
      ];

  expectThrowsInvalidMetadataError(builder);

  builder
     ..parameters = <ParameterMetadataBuilder>[
       parameter('_0'),
       parameter('_1'),
       namedParameter('_2'),
       parameter('_3')
     ];

  expectThrowsInvalidMetadataError(builder);
};

expectThrowsOnPositionalAndNamed(FunctionMetadataBuilder builder) => () {
  builder
      ..parameters = [
        parameter('_0'),
        positionalParameter('_1'),
        namedParameter('_2')
      ];

  expectThrowsInvalidMetadataError(builder);
};

expectThrowsOnInitializers(FunctionMetadataBuilder builder) => () {
  builder
      ..parameters = [
        parameter('foo')..isInitializer = true
      ];

  expectThrowsInvalidMetadataError(builder);
};
