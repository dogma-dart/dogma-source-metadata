// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/search.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  var context = analysisContext();

  test('constructor tests', () {
    var library = libraryMetadata(join('test/lib/constructors.dart'), context);
    var clazz;
    var constructors;
    var constructor;
    var parameters;
    var parameter;

    // Get the class with a generated default constructor
    clazz = metadataByNameQuery/*<ClassMetadata>*/(
        library,
        'SyntheticConstructor',
        includeClasses: true
    );

    expect(clazz, isNotNull);

    constructors = clazz.constructors;
    expect(constructors.length, 1);

    constructor = constructors[0];
    expect(constructor.isDefault, true);
    expect(constructor.isPrivate, false);
    expect(constructor.isFactory, false);
    expect(constructor.parameters.length, 0);

    // Get the class with a defined default constructor
    clazz = metadataByNameQuery/*<ClassMetadata>*/(
        library,
        'DefaultConstructor',
        includeClasses: true
    );

    expect(clazz, isNotNull);

    constructors = clazz.constructors;
    expect(constructors.length, 1);

    constructor = constructors[0] as ConstructorMetadata;
    expect(constructor.isDefault, true);
    expect(constructor.isPrivate, false);
    expect(constructor.isFactory, false);

    parameters = constructor.parameters;
    expect(parameters.length, 1);

    parameter = parameters[0];
    expect(parameter.type, new TypeMetadata.int());
    expect(parameter.name, 'value');

    // Get the class with a named constructor
    clazz = metadataByNameQuery/*<ClassMetadata>*/(
        library,
        'NamedConstructor',
        includeClasses: true
    );

    expect(clazz, isNotNull);

    constructors = clazz.constructors;
    expect(constructors.length, 1);

    constructor = constructors[0] as ConstructorMetadata;
    expect(constructor.isDefault, false);
    expect(constructor.isPrivate, false);
    expect(constructor.isFactory, false);
    expect(constructor.name, 'valued');

    parameters = constructor.parameters;
    expect(parameters.length, 1);

    parameter = parameters[0];
    expect(parameter.type, new TypeMetadata.int());
    expect(parameter.name, 'value');

    // Get the class with a factory constructor and private constructor
    clazz = metadataByNameQuery/*<ClassMetadata>*/(
        library,
        'FactoryConstructor',
        includeClasses: true
    );

    expect(clazz, isNotNull);

    constructors = clazz.constructors;
    expect(constructors.length, 2);

    // Shouldn't have a default constructor
    constructor = classDefaultConstructorQuery(clazz);
    expect(constructor, isNull);

    // Should have a private constructor
    constructors = classPrivateConstructorQueryAll(clazz).toList();
    expect(constructors.length, 1);

    constructor = constructors[0];
    expect(constructor.name, '_');
    expect(constructor.isDefault, false);
    expect(constructor.isPrivate, true);
    expect(constructor.isFactory, false);

    // Should have a named constructor
    constructors = classFactoryConstructorQueryAll(clazz).toList();
    expect(constructors.length, 1);

    constructor = constructors[0];
    expect(constructor.name, 'valued');
    expect(constructor.isDefault, false);
    expect(constructor.isPrivate, false);
    expect(constructor.isFactory, true);
  });
}
