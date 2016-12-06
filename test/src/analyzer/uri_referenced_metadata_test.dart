// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_metadata_test/test.dart';
import 'package:test/test.dart';

import 'package:dogma_source_metadata/analyzer.dart';
import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/path.dart';
import 'package:dogma_source_metadata/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('import tests', () {
    final library = libraryMetadata(join('test/lib/imports.dart'), context);

    print('Imports');
    for (var import in library.imports) {
      print(import.library.uri);
    }
  });
  test('export tests', () {
    final library = libraryMetadata(join('test/lib/exports.dart'), context);

    print('Exports');
    for (var export in library.exports) {
      print(export.library.uri);
    }
  });
}
