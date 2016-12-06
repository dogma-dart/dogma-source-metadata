// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata.dart';
import 'library_metadata.dart';
import 'enclosing_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata which corresponds to `import` and `export` declarations.
class UriReferencedMetadata extends Metadata with EnclosedMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The prefix to use for the reference.
  final String prefix;
  /// Whether loading of the library should be deferred.
  final bool deferred;
  /// The names within the library that are shown.
  final List<String> shownNames;
  /// The names within the library that are hidden.
  final List<String> hiddenNames;
  /// The metadata for the library being referenced.
  LibraryMetadata library;
  /// The configuration specific imports.
  ///
  /// The keys of the map correspond to the if clause for the configuration
  /// with the library metadata being used.
  final Map<String, LibraryMetadata> when;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates an instance of [UriReferencedMetadata].
  ///
  /// A [prefix] can be specified which corresponds to an `as` directive in
  /// an import.
  ///
  ///     import 'dart:html' as html;
  ///
  /// Additionally the import can be declared as [deferred] which allows the
  /// library to be loaded dynamically.
  ///
  ///     import 'package:foo/bar.dart' deferred as bar;
  ///
  /// The [shownNames] and [hiddenNames] correspond to the `show` and `hide`
  /// directives within an import or export statement.
  ///
  ///     import 'dart:html' show Element;
  ///     import 'dart:async' hide Completer;
  ///
  /// Configuration specific imports can be provided in a [when].
  ///
  ///     import 'library_interface.dart'
  ///         if (dart.library.io) 'library_io.dart'
  ///         if (dart.library.html) 'library_html.dart';
  UriReferencedMetadata({String prefix,
                         this.deferred: false,
                         List<String> shownNames,
                         List<String> hiddenNames,
                         this.library,
                         Map<String, LibraryMetadata> when})
      : prefix = prefix ?? ''
      , shownNames = shownNames ?? <String>[]
      , hiddenNames = hiddenNames ?? <String>[]
      , when = when ?? <String, LibraryMetadata>{}
      , super('');
}
