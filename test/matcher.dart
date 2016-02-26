// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'src/matcher/abstract_metadata_test.dart' as abstract_metadata_test;
import 'src/matcher/class_metadata_test.dart' as class_metadata_test;
import 'src/matcher/constructor_metadata_test.dart' as constructor_metadata_test;
import 'src/matcher/field_metadata_test.dart' as field_metadata_test;
import 'src/matcher/privacy_metadata_test.dart' as privacy_metadata_test;
import 'src/matcher/static_metadata_test.dart' as static_metadata_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  group('AbstractMetadata', abstract_metadata_test.main);
  group('ClassMetadata', class_metadata_test.main);
  group('ConstructorMetadata', constructor_metadata_test.main);
  group('FieldMetadata', field_metadata_test.main);
  group('PrivacyMetadata', privacy_metadata_test.main);
  group('StaticMetadataTest', static_metadata_test.main);
}
