// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'src/analyzer/field_metadata_test.dart' as field_metadata_test;
import 'src/metadata/type_metadata_test.dart' as type_metadata_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  group('Analyzer tests', () {
    group('FieldMetadata', field_metadata_test.main);
  });
  group('Metadata tests', () {
    group('TypeMetadata', type_metadata_test.main);
  });
}
