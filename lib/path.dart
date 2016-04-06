// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Functions for handling uri paths.
///
/// The majority of the functions are wrappers around functionality found in
/// the `path` library. They are expanded to support Uri values which are used
/// heavily within the analyzer to get paths to resources.
library dogma_source_analyzer.path;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:path/path.dart' as p;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The path to the current working directory expressed as a Uri.
///
/// It is assumed that the current path is within the root of a package. If
/// that is not the case then this value will be incorrect.
final Uri currentPathUri = p.toUri(p.current);

/// The current path running the application.
///
/// Parses the current path using the path based on the environment and then
/// converts to a posix style. This is done to ensure that paths are handled
/// consistently as all path operations will be done using the posix
/// implementation held in path.
final String currentPath = currentPathUri.toFilePath(windows: false);

/// Joins the [path] into the [base].
///
/// If [base] is not specified then the [currentPathUri] is used instead.
Uri join(String path, {dynamic base}) {
  // Default to the current path
  base ??= currentPath;

  // Get the base path and scheme
  var basePath = _uriPath(base);
  var baseScheme = _uriScheme(base);

  // Get the normalized value path
  var toPath = _uriPath(path);

  // Join the path
  var joined = p.posix.normalize(p.posix.join(basePath, toPath));

  // Create the URI
  return new Uri(scheme: baseScheme, path: joined);
}

/// Gets the relative path [from] the [value].
///
/// If [from] is not specified then [currentPathUri] is used.
String relative(dynamic path, {dynamic from}) {
  from ??= currentPath;

  // Get the schemes
  var pathScheme = _uriScheme(path);
  var fromScheme = _uriScheme(from);

  if (pathScheme != fromScheme) {
    throw new ArgumentError('The schemes of the values do not match');
  }

  // Turn into a path
  var fromPath = _uriPath(from);
  var toPath = _uriPath(path);

  // Convert from into the dirname
  fromPath = _isDirectory(fromPath) ? fromPath : p.posix.dirname(fromPath);

  // Get the relative path
  return p.posix.relative(toPath, from: fromPath);
}

/// Returns `true` if [child] is a path beneath `parent`, and `false`
/// otherwise.
///
///     isWithin('/root/path', '/root/path/a'); // -> true
///     isWithin('/root/path', '/root/other'); // -> false
///     isWithin('/root/path', '/root/path'); // -> false
bool isWithin(dynamic parent, dynamic child) {
  // Turn into a path
  var parentPath = _uriPath(parent);
  var childPath = _uriPath(child);

  return p.posix.isWithin(parentPath, childPath);
}

/// Gets the part of [path] before the last separator.
///
///     dirname('path/to/foo.dart'); // -> 'path/to'
///     dirname('path/to');          // -> 'path'
///
/// Trailing separators are ignored.
///
///     dirname('path/to/'); // -> 'path'
String dirname(dynamic path) => p.posix.dirname(_uriPath(path));

/// Gets the part of [path] after the last separator.
///
///     basename('path/to/foo.dart');                    // -> 'foo.dart'
///     basename('path/to');                             // -> 'to'
///     basename(Uri.parse('package:path/to/foo.dart')); // -> 'foo.dart'
///     basename(Uri.parse('package:path/to'));          // -> 'to'
///
/// Trailing separators are ignored.
///
///     basename('path/to/'); // -> 'to'
String basename(dynamic value) => p.posix.basename(_uriPath(value));

/// Gets
String basenameWithoutExtension(dynamic value) =>
    p.posix.basenameWithoutExtension(_uriPath(value));

/// Checks whether the [path] can be imported through package notation.
bool canImportAsPackage(dynamic path) {
  var pathScheme = _uriScheme(path);

  // See if its already a package path
  if (pathScheme == 'package') {
    return true;
  }

  var parentPath = _libPath();
  var childPath = _uriPath(path);

  return p.posix.isWithin(parentPath, childPath);
}

/// Converts the [path] to a package Uri with the given [name].
///
/// To verify that this function can be used [canImportAsPackage] should be
/// called first.
Uri asPackageImport(dynamic path, String name) {
  var pathScheme = _uriPath(path);

  // See if its already a package path
  if (pathScheme == 'package') {
    var uri = path as Uri;

    if (uri.pathSegments[0] == name) {
      return uri;
    } else {
      throw new ArgumentError.value(path, 'Is already a package but not the package specified');
    }
  }

  var parentPath = _libPath();
  var childPath = _uriPath(path);

  if (!p.posix.isWithin(parentPath, childPath)) {
    throw new ArgumentError.value(path, 'The path is not within the lib directory');
  }

  var relativePath = p.posix.relative(childPath, from: parentPath);

  return new Uri(scheme: 'package', path: p.join(name, relativePath));
}

/// Gets the path of a package library from the current path.
String _libPath() => p.posix.join(_uriPath(currentPathUri), 'lib');

/// Returns the normalized path of the value.
String _uriPath(dynamic value) =>
    (value is Uri)
        ? value.normalizePath().path
        : p.posix.normalize(p.posix.joinAll(p.split(value)));

/// Returns the scheme of a URI.
///
/// If the value is not a URI then it is assumed to be a file uri.
String _uriScheme(dynamic value) => (value is Uri) ? value.scheme : 'file';

/// Checks to see if the [value] is a directory.
bool _isDirectory(String value) => p.posix.withoutExtension(value) == value;
