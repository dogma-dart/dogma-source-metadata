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

import '../../lib/annotation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void _expectHasAnnotation(AnnotatedMetadata metadata, String value) {
  expect(metadata.annotations, hasLength(1));

  final annotation = metadata.annotations[0];
  expect(annotation is Annotation, isTrue);
  expect(annotation.value, value);
}

void _expectParamHasAnnotation(FunctionMetadata metadata, String value) {
  expect(metadata.parameters, hasLength(1));

  _expectHasAnnotation(metadata.parameters[0], value);
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('annotation', () {
    final create = analyzeAnnotation('Annotation');
    final library = libraryMetadata(
        join('test/lib/annotation.dart'),
        context,
        annotationCreators: [create]
    );

    expect(library, isNotNull);
    expect(library.classes, hasLength(4));
    expect(library.fields, hasLength(1));
    expect(library.functions, hasLength(1));

    // Check library annotations
    _expectHasAnnotation(library, 'library');
    _expectHasAnnotation(library.fields[0], 'library_field');
    _expectHasAnnotation(library.functions[0], 'function');
    _expectParamHasAnnotation(library.functions[0], 'function_parameter');

    final clazz = libraryMetadataQuery<ClassMetadata>(
        library,
        nameMatch('Annotated'),
        includeClasses: true,
    );

    expect(clazz, isNotNull);
    expect(clazz.constructors, hasLength(1));
    expect(clazz.fields, hasLength(2));
    expect(clazz.methods, hasLength(1));

    // Check class annotations
    _expectHasAnnotation(clazz, 'class');
    _expectHasAnnotation(clazz.constructors[0], 'constructor');
    _expectHasAnnotation(clazz.methods[0], 'method');
    _expectParamHasAnnotation(clazz.methods[0], 'parameter');

    // Check field annotations
    //
    // There's on property and one field
    for (var field in clazz.fields) {
      final value = field.isProperty ? 'property' : 'field';

      _expectHasAnnotation(field, value);
    }
  });
}
