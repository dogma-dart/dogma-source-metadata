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

UriReferencedMetadata _getReference(Iterable<UriReferencedMetadata> references, Uri uri) {
  final reference = references.firstWhere(
      (value) => value.library.uri == uri,
      orElse: () => null
  );

  expect(reference, isNotNull);

  return reference;
}

/// Entry point for tests.
void main() {
  final context = analysisContext();

  test('import tests', () {
    final library = libraryMetadata(join('test/lib/imports.dart'), context);

    final asImport = _getReference(library.imports, Uri.parse('dart:html'));
    expect(asImport, isPrefixed);
    expect(asImport, prefixedBy('html'));
    expect(asImport, notDeferred);

    final showImport = _getReference(library.imports, join('test/lib/functions.dart'));
    expect(showImport, notPrefixed);
    expect(showImport, showsName('empty'));
    expect(showImport, notDeferred);

    final hideImport = _getReference(library.imports, join('test/lib/annotation.dart'));
    expect(hideImport, notPrefixed);
    expect(hideImport, notDeferred);
    expect(hideImport, hidesName('Annotated'));
    expect(hideImport, hidesName('AnnotationTypes'));

    final deferredImport = _getReference(library.imports, join('test/lib/deprecated.dart'));
    expect(deferredImport, isPrefixed);
    expect(deferredImport, prefixedBy('deprecated'));
    expect(deferredImport, isDeferred);

    final interfaceImport = _getReference(library.imports, join('test/lib/library_interface.dart'));
    expect(interfaceImport, notPrefixed);
  });
  test('export tests', () {
    final library = libraryMetadata(join('test/lib/exports.dart'), context);

    print('Exports');
    for (var export in library.exports) {
      print(export.library.uri);
    }
  });
}
