// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Checks the [metadata] for default values of [AbstractMetadata].
void expectAbstractMetadataDefaults(AbstractMetadata metadata) {
  expect(metadata.isAbstract, isFalse);
}

/// Checks the [metadata] for default values of [AnnotatedMetadata].
void expectAnnotatedMetadataDefaults(AnnotatedMetadata metadata) {
  expect(metadata.annotations, isEmpty);
  expect(metadata.comments, isEmpty);
}

/// Checks the [metadata] for default values of [PrivacyMetadata].
void expectPrivacyMetadataDefaults(PrivacyMetadata metadata) {
  expect(metadata.isPrivate, isFalse);
  expect(metadata.isPublic, isTrue);
}

/// Checks the [metadata] for default values of [StaticMetadata].
void expectStaticMetadataDefaults(StaticMetadata metadata) {
  expect(metadata.isStatic, isFalse);
}

/// Checks the [metadata] for default values of [FunctionMetadata].
void expectFunctionMetadataDefaults(FunctionMetadata metadata) {
  expect(metadata.parameters, isEmpty);
}
