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

ClassMetadata _getClass(LibraryMetadata library, String name) {
  final clazz = libraryMetadataQuery/*<ClassMetadata>*/(
      library,
      nameMatch(name),
      includeClasses: true
  );

  expect(clazz, isNotNull);
  expect(clazz.name, name);
  expect(clazz.enclosingMetadata, library);

  return clazz;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('constructor tests', () {
    final library = libraryMetadata(join('test/lib/constructors.dart'), context);
    var clazz;
    var constructors;
    var constructor;
    var parameters;
    var parameter;

    // Get the class with a generated default constructor
    clazz = _getClass(library, 'SyntheticConstructor');

    constructors = clazz.constructors;
    expect(constructors, hasLength(1));

    constructor = constructors[0];
    expect(constructor.isDefault, isTrue);
    expect(constructor.isPrivate, isFalse);
    expect(constructor.isFactory, isFalse);
    expect(constructor.parameters, isEmpty);

    // Get the class with a defined default constructor
    clazz = _getClass(library, 'DefaultConstructor');

    constructors = clazz.constructors;
    expect(constructors, hasLength(1));

    constructor = constructors[0] as ConstructorMetadata;
    expect(constructor.isDefault, isTrue);
    expect(constructor.isPrivate, isFalse);
    expect(constructor.isFactory, isFalse);

    parameters = constructor.parameters;
    expect(parameters, hasLength(1));

    parameter = parameters[0];
    expect(parameter.type, new TypeMetadata.int());
    expect(parameter.name, 'value');
    expect(parameter.isInitializer, isTrue);

    // Get the class with a named constructor
    clazz = _getClass(library, 'NamedConstructor');

    constructors = clazz.constructors;
    expect(constructors, hasLength(1));

    constructor = constructors[0] as ConstructorMetadata;
    expect(constructor.isDefault, isFalse);
    expect(constructor.isPrivate, isFalse);
    expect(constructor.isFactory, isFalse);
    expect(constructor.name, 'valued');

    parameters = constructor.parameters;
    expect(parameters, hasLength(1));

    parameter = parameters[0];
    expect(parameter.type, new TypeMetadata.int());
    expect(parameter.name, 'value');
    expect(parameter.isInitializer, isTrue);

    // Get the class with a factory constructor and private constructor
    clazz = _getClass(library, 'FactoryConstructor');

    constructors = clazz.constructors;
    expect(constructors, hasLength(2));

    // Shouldn't have a default constructor
    constructor = classMetadataQuery/*<ConstructorMetadata>*/(
        clazz,
        defaultConstructorMatch,
        includeConstructors: true
    );
    expect(constructor, isNull);

    // Should have a private constructor
    constructors = classMetadataQueryAll/*<ConstructorMetadata>*/(
        clazz,
        privateMatch,
        includeConstructors: true
    );
    expect(constructors, hasLength(1));

    constructor = constructors.first;
    expect(constructor.name, '_');
    expect(constructor.isDefault, isFalse);
    expect(constructor.isPrivate, isTrue);
    expect(constructor.isFactory, isFalse);

    // Should have a named constructor
    constructors = classMetadataQueryAll/*<ConstructorMetadata>*/(
        clazz,
        and(namedConstructorMatch, publicMatch),
        includeConstructors: true
    );
    expect(constructors, hasLength(1));

    constructor = constructors.first;
    expect(constructor.name, 'valued');
    expect(constructor.isDefault, isFalse);
    expect(constructor.isPrivate, isFalse);
    expect(constructor.isFactory, isTrue);
  });
}
