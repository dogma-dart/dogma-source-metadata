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

final ClassMetadata _privateClass =
    new ClassMetadata('_Private', isPrivate: true);
final ClassMetadata _publicClass = new ClassMetadata('Public');
final Metadata _notPrivateMetadata = new Metadata('NotPrivate');

/// Entry point for tests.
void main() {
  test('privacyMetadataMatch', () {
    expect(privacyMetadataMatch(_privateClass), isTrue);
    expect(privacyMetadataMatch(_publicClass), isTrue);
    expect(privacyMetadataMatch(_notPrivateMetadata), isFalse);
  });
  test('privateMatch', () {
    expect(privateMatch(_privateClass), isTrue);
    expect(privateMatch(_publicClass), isFalse);
    expect(() => privateMatch(_notPrivateMetadata), throws);
    expect(and(privacyMetadataMatch, privateMatch)(_notPrivateMetadata), isFalse);
  });
  test('publicMatch', () {
    expect(publicMatch(_privateClass), isFalse);
    expect(publicMatch(_publicClass), isTrue);
    expect(() => publicMatch(_notPrivateMetadata), throws);
    expect(and(privacyMetadataMatch, publicMatch)(_notPrivateMetadata), isFalse);
  });
}
