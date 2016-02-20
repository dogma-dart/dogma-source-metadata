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
    expect(metadata.isOptional, false);
    expect(metadata.isRequired, true);
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
    expect(required.isOptional, false);
    expect(required.isRequired, true);

    var optionalName = 'optional';
    var optionalType = new TypeMetadata.bool();
    var optional = new ParameterMetadata(
        optionalName,
        optionalType,
        parameterKind: ParameterKind.optional
    );

    expectAnnotatedMetadataDefaults(optional);
    expect(optional.name, optionalName);
    expect(optional.type, optionalType);
    expect(optional.parameterKind, ParameterKind.optional);
    expect(optional.isOptional, true);
    expect(optional.isRequired, false);

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
    expect(named.isOptional, true);
    expect(named.isRequired, false);
  });
}
