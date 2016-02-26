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

final ClassMetadata _abstractClass =
new ClassMetadata('Abstract', isAbstract: true);
final ClassMetadata _concreteClass =
new ClassMetadata('Concrete', isAbstract: false);
final Metadata _notAbstractMetadata = new Metadata('NotAbstract');

void main() {
  test('abstractMetadataMatch', () {
    expect(abstractMetadataMatch(_abstractClass), isTrue);
    expect(abstractMetadataMatch(_concreteClass), isTrue);
    expect(abstractMetadataMatch(_notAbstractMetadata), isFalse);
  });
  test('abstractMatch', () {
    expect(abstractMatch(_abstractClass), isTrue);
    expect(abstractMatch(_concreteClass), isFalse);
    expect(() => abstractMatch(_notAbstractMetadata), throws);
    expect(and(abstractMetadataMatch, abstractMatch)(_notAbstractMetadata), isFalse);
  });
  test('concreteMatch', () {
    expect(concreteMatch(_abstractClass), isFalse);
    expect(concreteMatch(_concreteClass), isTrue);
    expect(() => concreteMatch(_notAbstractMetadata), throws);
    expect(and(abstractMetadataMatch, concreteMatch)(_notAbstractMetadata), isFalse);
  });
}
