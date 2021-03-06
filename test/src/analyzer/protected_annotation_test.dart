// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_metadata/analyzer.dart';
import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/path.dart';
import 'package:dogma_source_metadata/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void _expectHasProtected(AnnotatedMetadata metadata) {
  expect(metadata, isNotNull);
  expect(metadata, hasAnnotations(1));
  expect(metadata, isProtected);
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('@protected', () {
    final library = libraryMetadata(
        join('test/lib/protected.dart'),
        context
    );

    expect(library, isNotNull);
    expect(library, hasClasses(2));
    expect(library, hasNoFields);
    expect(library, hasNoFunctions);
    expect(library, hasNoTypedefs);

    final clazz = libraryMetadataQuery<ClassMetadata>(
        library,
        nameMatch('Base'),
        includeClasses: true
    );

    expect(clazz, isNotNull);
    expect(clazz, hasMethods(1));
    expect(clazz, hasNoFields);

    final method = classMetadataQuery<MethodMetadata>(
        clazz,
        nameMatch('onlySubClasses'),
        includeMethods: true
    );

    expect(method, isNotNull);
    expect(method, hasAnnotations(1));
    expect(method, isProtected);
  });
}
