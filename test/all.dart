// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

// \TODO Remove this file after https://github.com/dart-lang/test/issues/36 is resolved.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';
import 'package:logging/logging.dart';

import 'src/analyzer/constructor_metadata_test.dart' as constructor_metadata_test;
import 'src/analyzer/field_metadata_test.dart' as field_metadata_test;
import 'src/analyzer/function_metadata_test.dart' as function_metadata_test;

import 'src/metadata/parameter_metadata_test.dart' as parameter_metadata_test;
import 'src/metadata/type_metadata_test.dart' as type_metadata_test;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  // Start logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  // Run analyzer tests
  group('Analyzer tests', () {
    group('ConstructorMetadata', constructor_metadata_test.main);
    group('FieldMetadata', field_metadata_test.main);
    group('FunctionMetadata', function_metadata_test.main);
  });

  // Run metadata test
  group('Metadata tests', () {
    group('ParameterMetadata', parameter_metadata_test.main);
    group('TypeMetadata', type_metadata_test.main);
  });
}
