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
  var context = analysisContext();

  test('function tests', () {
    var library = libraryMetadata(join('test/lib/union_type.dart'), context);

    var function;

    function = libraryMetadataQuery/*<FunctionMetadata*/(
        library,
        nameMatch('function'),
        includeFunctions: true
    );

    expect(function, isNotNull);
    expect(function.returnType, new TypeMetadata('void'));
    expect(function.parameters, hasLength(1));
  });
}
