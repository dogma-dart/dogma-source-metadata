// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Checks the [metadata] for default values of [AbstractMetadata].
void expectAbstractMetadataDefaults(AbstractMetadata metadata) {
  expect(metadata, isAbstract);
}

/// Checks the [metadata] for default values of [AnnotatedMetadata].
void expectAnnotatedMetadataDefaults(AnnotatedMetadata metadata) {
  expect(metadata, notAnnotated);
  expect(metadata, uncommented);
}

/// Checks the [metadata] for default values of [StaticMetadata].
void expectStaticMetadataDefaults(StaticMetadata metadata) {
  expect(metadata, isStatic);
}

/// Checks the [metadata] for default values of [FunctionMetadata].
void expectFunctionMetadataDefaults(FunctionMetadata metadata) {
  expect(metadata, noParameters);
}
