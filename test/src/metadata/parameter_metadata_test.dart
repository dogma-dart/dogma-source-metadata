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

import 'base_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('default constructor', () {
    final name = 'default';
    final metadata = new ParameterMetadata(name);

    expectAnnotatedMetadataDefaults(metadata);
    expect(metadata, isPublic);
    expect(metadata, isNamed(name));
    expect(metadata, isDynamicType);
    expect(metadata, isRequiredParameter);
    expect(metadata, isNotInitializer);
    expect(metadata.isInitializer, isFalse);
    expect(metadata.isOptional, isFalse);
    expect(metadata.isRequired, isTrue);
  });

  test('property test', () {
    final requiredName = 'required';
    final required = new ParameterMetadata(
        requiredName,
        parameterKind: ParameterKind.required
    );

    expectAnnotatedMetadataDefaults(required);
    expect(required, isPublic);
    expect(required, isNamed(requiredName));
    expect(required, isDynamicType);
    expect(required, isRequiredParameter);
    expect(required, isNotInitializer);
    expect(required.isOptional, isFalse);
    expect(required.isRequired, isTrue);

    final positionalName = 'positional';
    final positional = new ParameterMetadata(
        positionalName,
        parameterKind: ParameterKind.positional
    );

    expectAnnotatedMetadataDefaults(positional);
    expect(positional, isPublic);
    expect(positional, isNamed(positionalName));
    expect(positional, isDynamicType);
    expect(positional, isPositionalParameter);
    expect(positional, isNotInitializer);
    expect(positional.isOptional, isTrue);
    expect(positional.isRequired, isFalse);

    final namedName = 'named';
    final named = new ParameterMetadata(
        namedName,
        parameterKind: ParameterKind.named
    );

    expectAnnotatedMetadataDefaults(named);
    expect(named, isPublic);
    expect(named, isNamed(namedName));
    expect(named, isDynamicType);
    expect(named, isNamedParameter);
    expect(named, isNotInitializer);
    expect(named.isOptional, isTrue);
    expect(named.isRequired, isFalse);
  });
}
