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

TypedefMetadata _getTypedef(LibraryMetadata library, String name) {
  final typedef = libraryMetadataQuery<TypedefMetadata>(
      library,
      nameMatch(name),
      includeTypedefs: true,
  );

  expect(typedef, isNotNull);
  expect(typedef, isNamed(name));
  expect(typedef, isTypedefMetadata);
  expect(typedef, enclosedBy(library));

  return typedef;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('typedef tests', () {
    final library = libraryMetadata(join('test/lib/typedef.dart'), context);

    final empty = _getTypedef(library, 'EmptyFunction');
    final emptyType = functionType(returnType: voidType);

    expect(empty, isType(emptyType));

    final param = _getTypedef(library, 'ParamFunction');
    final paramType = functionType(
        returnType: stringType,
        parameterTypes: <TypeMetadata>[stringType, stringType],
    );

    expect(param, isType(paramType));
    expect(param, hasParameterLength(2));

    final generic = _getTypedef(library, 'GenericFunction');
    final genericType = functionType(
        returnType: parameterizedType('T'),
        parameterTypes: <TypeMetadata>[parameterizedType('T')],
        typeArguments: <TypeMetadata>[parameterizedType('T')],
    );

    expect(generic, isType(genericType));
    expect(generic, hasParameterLength(1));
  });
}
