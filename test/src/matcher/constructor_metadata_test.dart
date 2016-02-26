// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final TypeMetadata _constructorType = new TypeMetadata('Foo');
final ConstructorMetadata _defaultConstructor =
    new ConstructorMetadata(_constructorType, isFactory: false);
final ConstructorMetadata _namedConstructor =
    new ConstructorMetadata.named('named', _constructorType, isFactory: false);
final ConstructorMetadata _defaultFactoryConstructor =
    new ConstructorMetadata(_constructorType, isFactory: true);
final ConstructorMetadata _factoryConstructor =
    new ConstructorMetadata.named('factor', _constructorType, isFactory: true);
final Metadata _notConstructorMetadata = new Metadata('NotConstructor');

void main() {
  test('constructorMetadataMatch', () {
    expect(constructorMetadataMatch(_defaultConstructor), isTrue);
    expect(constructorMetadataMatch(_namedConstructor), isTrue);
    expect(constructorMetadataMatch(_defaultFactoryConstructor), isTrue);
    expect(constructorMetadataMatch(_factoryConstructor), isTrue);
    expect(constructorMetadataMatch(_notConstructorMetadata), isFalse);
  });
  test('defaultConstructorMatch', () {
    expect(defaultConstructorMatch(_defaultConstructor), isTrue);
    expect(defaultConstructorMatch(_namedConstructor), isFalse);
    expect(defaultConstructorMatch(_defaultFactoryConstructor), isTrue);
    expect(defaultConstructorMatch(_factoryConstructor), isFalse);
    expect(() => defaultConstructorMatch(_notConstructorMetadata), throws);
    expect(and(constructorMetadataMatch, defaultConstructorMatch)(_notConstructorMetadata), isFalse);
  });
  test('factoryConstructorMatch', () {
    expect(factoryConstructorMatch(_defaultConstructor), isFalse);
    expect(factoryConstructorMatch(_namedConstructor), isFalse);
    expect(factoryConstructorMatch(_defaultFactoryConstructor), isTrue);
    expect(factoryConstructorMatch(_factoryConstructor), isTrue);
    expect(() => factoryConstructorMatch(_notConstructorMetadata), throws);
    expect(and(constructorMetadataMatch, factoryConstructorMatch)(_notConstructorMetadata), isFalse);
  });
  test('namedConstructorMatch', () {
    expect(namedConstructorMatch(_defaultConstructor), isFalse);
    expect(namedConstructorMatch(_namedConstructor), isTrue);
    expect(namedConstructorMatch(_defaultFactoryConstructor), isFalse);
    expect(namedConstructorMatch(_factoryConstructor), isTrue);
    expect(() => namedConstructorMatch(_notConstructorMetadata), throws);
    expect(and(constructorMetadataMatch, namedConstructorMatch)(_notConstructorMetadata), isFalse);
  });
}
