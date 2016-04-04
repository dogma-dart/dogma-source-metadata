// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'src/analyzer/annotation_test.dart' as annotation_test;
import 'src/analyzer/class_metadata_test.dart' as class_metadata_test;
import 'src/analyzer/constructor_metadata_test.dart' as constructor_metadata_test;
import 'src/analyzer/field_metadata_test.dart' as field_metadata_test;
import 'src/analyzer/function_metadata_test.dart' as function_metadata_test;
import 'src/analyzer/mirrors_test.dart' as mirrors_test;
import 'src/analyzer/type_metadata_test.dart' as type_metadata_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  group('Annotation', annotation_test.main);
  group('ClassMetadata', class_metadata_test.main);
  group('ConstructorMetadata', constructor_metadata_test.main);
  group('FieldMetadata', field_metadata_test.main);
  group('FunctionMetadata', function_metadata_test.main);
  group('Mirrors', mirrors_test.main);
  group('TypeMetadata', type_metadata_test.main);
}
