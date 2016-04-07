// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void _expectHasProtected(AnnotatedMetadata metadata) {
  expect(metadata.annotations, hasLength(1));

  var annotation = metadata.annotations[0];
  expect(annotation, protected);
}

/// Entry point for tests.
void main() {
  var context = analysisContext();

  test('@protected', () {
    var library = libraryMetadata(
        join('test/lib/protected.dart'),
        context
    );

    expect(library, isNotNull);
    expect(library.classes, hasLength(2));
    expect(library.fields, isEmpty);
    expect(library.functions, isEmpty);

    var clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('Base'),
        includeClasses: true
    ) as ClassMetadata;

    expect(clazz, isNotNull);
    expect(clazz.methods, hasLength(1));

    var method = classMetadataQuery/*<MethodMetadata>*/(
        clazz,
        nameMatch('onlySubClasses'),
        includeMethods: true
    );

    expect(method, isNotNull);
    _expectHasProtected(method);
  });
}
