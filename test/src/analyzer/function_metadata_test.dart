// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('function tests', () {
    final library = libraryMetadata(join('test/lib/functions.dart'), context);

    var function;

    function = libraryMetadataQuery/*<FunctionMetadata*/(
        library,
        nameMatch('empty'),
        includeFunctions: true
    );

    expect(function, isNotNull);
    expect(function.returnType, voidType);
    expect(function.parameters, isEmpty);
  });
}
