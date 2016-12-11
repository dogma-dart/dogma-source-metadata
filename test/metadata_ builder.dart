// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'src/metadata_builder/constructor_metadata_builder_test.dart' as constructor_metadata_builder_test;
import 'src/metadata_builder/enum_metadata_builder_test.dart' as enum_metadata_builder_test;
import 'src/metadata_builder/field_metadata_builder_test.dart' as field_metadata_builder_test;
import 'src/metadata_builder/function_metadata_builder_test.dart' as function_metadata_builder_test;
import 'src/metadata_builder/method_metadata_builder_test.dart' as method_metadata_builder_test;
import 'src/metadata_builder/parameter_metadata_builder_test.dart' as parameter_metadata_builder_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  group('ConstructorMetadataBuilder', constructor_metadata_builder_test.main);
  group('EnumMetadataBuilder', enum_metadata_builder_test.main);
  group('FieldMetadataBuilder', field_metadata_builder_test.main);
  group('FunctionMetadataBuilder', function_metadata_builder_test.main);
  group('MethodMetadataBuilder', method_metadata_builder_test.main);
  group('ParameterMetadataBuilder', parameter_metadata_builder_test.main);
}
