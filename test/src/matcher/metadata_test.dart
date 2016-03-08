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

final _aName = 'A';
final _bName = 'B';

final Metadata _a = new Metadata(_aName);
final Metadata _b = new Metadata(_bName);

void main() {
  test('nameMatch', () {
    expect(nameMatch(_aName)(_a), isTrue);
    expect(nameMatch(_aName)(_b), isFalse);
    expect(nameMatch(_bName)(_a), isFalse);
    expect(nameMatch(_bName)(_b), isTrue);
  });
}
