// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_metadata/analyzer.dart';
import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/path.dart';
import 'package:dogma_source_metadata/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('function tests', () {
    final library = libraryMetadata(join('test/lib/union_type.dart'), context);
    final function = libraryMetadataQuery<FunctionMetadata>(
        library,
        nameMatch('function'),
        includeFunctions: true,
    );

    expect(function, isNotNull);
    expect(function.returnType, voidType);
    expect(function.parameters, hasLength(1));
  });
}
