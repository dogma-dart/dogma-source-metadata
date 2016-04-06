// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';
import 'package:dogma_source_analyzer/path.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for tests.
void main() {
  test('join', () {
    var result;

    // Join file path
    result = join('a/b.dart');
    expect(result.scheme, 'file');
    expect(result.path.endsWith('a/b.dart'), isTrue);

    // Join package path
    result = join('src/a/b.dart', base: Uri.parse('package:foo'));
    expect(result.scheme, 'package');
    expect(result, Uri.parse('package:foo/src/a/b.dart'));

    // Test normalization of base
    result = join('src/a/b.dart', base: Uri.parse('package:foo/a/../'));
    expect(result.scheme, 'package');
    expect(result, Uri.parse('package:foo/src/a/b.dart'));

    // Test normalization of value
    result = join('src/a/../a/../a/b.dart', base: Uri.parse('package:foo'));
    expect(result.scheme, 'package');
    expect(result, Uri.parse('package:foo/src/a/b.dart'));
  });
  test('relative', () {
    var from;
    var to;

    // Default path test
    expect(relative(join('foo/a.dart')), 'foo/a.dart');

    // Join file path
    from = 'foo/a.dart';
    to = 'foo/b.dart';
    expect(relative(to, from: from), 'b.dart');

    from = 'foo/src/a.dart';
    to = 'foo/b.dart';
    expect(relative(to, from: from), '../b.dart');

    from = 'foo/a.dart';
    to = 'foo/src/b.dart';
    expect(relative(to, from: from), 'src/b.dart');

    // Join package path
    from = new Uri(scheme: 'package', path: 'foo/a.dart');
    to = new Uri(scheme: 'package', path: 'foo/b.dart');
    expect(relative(to, from: from), 'b.dart');

    from = new Uri(scheme: 'package', path: 'foo/src/a.dart');
    to = new Uri(scheme: 'package', path: 'foo/b.dart');
    expect(relative(to, from: from), '../b.dart');

    from = new Uri(scheme: 'package', path: 'foo/a.dart');
    to = new Uri(scheme: 'package', path: 'foo/src/b.dart');
    expect(relative(to, from: from), 'src/b.dart');

    // Error state
    from = join('foo/a.dart');
    to = new Uri(scheme: 'package', path: 'foo/a.dart');
    expect(() => relative(to, from: from), throwsArgumentError);
  });
  test('dirname', () {
    // Strings
    expect(dirname('path/to/foo.dart'), 'path/to');
    expect(dirname('path/to'), 'path');
    expect(dirname('path/to/'), 'path');
    expect(dirname('path/to/../to/foo.dart'), 'path/to');

    // Uris
    expect(dirname(Uri.parse('package:foo/to/foo.dart')), 'foo/to');
    expect(dirname(Uri.parse('package:foo/to')), 'foo');
    expect(dirname(Uri.parse('package:foo/to/')), 'foo');
    expect(dirname(Uri.parse('package:foo/to/../to/foo.dart')), 'foo/to');
  });
  test('basename', () {
    // Strings
    expect(basename('path/to/foo.dart'), 'foo.dart');
    expect(basename('path/to'), 'to');
    expect(basename('path/to/'), 'to');
    expect(basename('path/to/../to/foo.dart'), 'foo.dart');

    // Uris
    expect(basename(Uri.parse('package:foo/to/foo.dart')), 'foo.dart');
    expect(basename(Uri.parse('package:foo/to')), 'to');
    expect(basename(Uri.parse('package:foo/to/')), 'to');
    expect(basename(Uri.parse('package:foo/to/../to/foo.dart')), 'foo.dart');
  });
  test('basenameWithoutExtension', () {
    // Strings
    expect(basenameWithoutExtension('path/to/foo.dart'), 'foo');
    expect(basenameWithoutExtension('path/to'), 'to');
    expect(basenameWithoutExtension('path/to/'), 'to');
    expect(basenameWithoutExtension('path/to/../to/foo.dart'), 'foo');

    // Uris
    expect(basenameWithoutExtension(Uri.parse('package:foo/to/foo.dart')), 'foo');
    expect(basenameWithoutExtension(Uri.parse('package:foo/to')), 'to');
    expect(basenameWithoutExtension(Uri.parse('package:foo/to/')), 'to');
    expect(basenameWithoutExtension(Uri.parse('package:foo/to/../to/foo.dart')), 'foo');
  });
  test('canImportAsPackage', () {
    // Package should return true
    expect(canImportAsPackage(new Uri(scheme: 'package', path: 'foo/a.dart')), isTrue);

    // File path not in lib
    expect(canImportAsPackage(join('test/a.dart')), false);

    // File path in lib
    expect(canImportAsPackage(join('lib/a.dart')), true);
    expect(canImportAsPackage(join('lib/src/a.dart')), true);
  });
}
