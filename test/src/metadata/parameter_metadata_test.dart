// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

import 'base_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('default constructor', () {
    var name = 'default';
    var type = new TypeMetadata.bool();
    var metadata = new ParameterMetadata(name, type);

    expectAnnotatedMetadataDefaults(metadata);
    expect(metadata.name, name);
    expect(metadata.type, type);
    expect(metadata.parameterKind, ParameterKind.required);
    expect(metadata.isInitializer, isFalse);
    expect(metadata.isOptional, isFalse);
    expect(metadata.isRequired, isTrue);
  });

  test('property test', () {
    var requiredName = 'required';
    var requiredType = new TypeMetadata.bool();
    var required = new ParameterMetadata(
        requiredName,
        requiredType,
        parameterKind: ParameterKind.required
    );

    expectAnnotatedMetadataDefaults(required);
    expect(required.name, requiredName);
    expect(required.type, requiredType);
    expect(required.parameterKind, ParameterKind.required);
    expect(required.isInitializer, isFalse);
    expect(required.isOptional, isFalse);
    expect(required.isRequired, isTrue);

    var positionalName = 'positional';
    var positionalType = new TypeMetadata.bool();
    var positional = new ParameterMetadata(
        positionalName,
        positionalType,
        parameterKind: ParameterKind.positional
    );

    expectAnnotatedMetadataDefaults(positional);
    expect(positional.name, positionalName);
    expect(positional.type, positionalType);
    expect(positional.parameterKind, ParameterKind.positional);
    expect(positional.isInitializer, isFalse);
    expect(positional.isOptional, isTrue);
    expect(positional.isRequired, isFalse);

    var namedName = 'named';
    var namedType = new TypeMetadata.bool();
    var named = new ParameterMetadata(
        namedName,
        namedType,
        parameterKind: ParameterKind.named
    );

    expectAnnotatedMetadataDefaults(named);
    expect(named.name, namedName);
    expect(named.type, namedType);
    expect(named.parameterKind, ParameterKind.named);
    expect(named.isInitializer, isFalse);
    expect(named.isOptional, isTrue);
    expect(named.isRequired, isFalse);
  });
}
