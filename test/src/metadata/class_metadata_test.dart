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
    final className = 'Foo';
    final metadata = new ClassMetadata(className);

    // Base classes
    expectAbstractMetadataDefaults(metadata);
    expectAnnotatedMetadataDefaults(metadata);

    // ClassMetadata
    expect(metadata.name, className);
    expect(metadata.supertype, isNull);
    expect(metadata.interfaces, isEmpty);
    expect(metadata.mixins, isEmpty);
    expect(metadata.typeParameters, isEmpty);
    expect(metadata.fields, isEmpty);
    expect(metadata.methods, isEmpty);
    expect(metadata.constructors, isEmpty);
  });
}
