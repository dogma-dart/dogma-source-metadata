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
import 'src/matcher/constant_metadata_test.dart' as constant_metadata_test;
import 'src/matcher/constructor_metadata_test.dart' as constructor_metadata_test;
import 'src/matcher/field_metadata_test.dart' as field_metadata_test;
import 'src/matcher/function_metadata_test.dart' as function_metadata_test;
import 'src/matcher/metadata_match_function_test.dart' as metadata_match_function_test;
import 'src/matcher/metadata_test.dart' as metadata_test;
import 'src/matcher/parameter_metadata_test.dart' as parameter_metadata_test;
import 'src/matcher/privacy_metadata_test.dart' as privacy_metadata_test;
import 'src/matcher/static_metadata_test.dart' as static_metadata_test;
import 'src/matcher/typed_metadata_test.dart' as typed_metadata_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  group('AbstractMetadata', abstract_metadata_test.main);
  group('ClassMetadata', class_metadata_test.main);
  group('ConstantMetadata', constant_metadata_test.main);
  group('ConstructorMetadata', constructor_metadata_test.main);
  group('FieldMetadata', field_metadata_test.main);
  group('FunctionMetadata', function_metadata_test.main);
  group('Metadata', metadata_test.main);
  group('MetadataMatchFunction', metadata_match_function_test.main);
  group('ParameterMetadata', parameter_metadata_test.main);
  group('PrivacyMetadata', privacy_metadata_test.main);
  group('StaticMetadata', static_metadata_test.main);
  group('TypedMetadata', typed_metadata_test.main);
}
