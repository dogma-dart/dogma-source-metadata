// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'invalid_metadata_error.dart';
import 'library_metadata_builder.dart';
import 'metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [UriReferencedMetadata].
///
/// The [UriReferencedMetadataBuilder] does the following validations.
///
/// * The reference may either show names or hide names but not both.
class UriReferencedMetadataBuilder extends MetadataBuilder<UriReferencedMetadata> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The condition for a `dart:io` context.
  static const String dartIoCondition = 'dart.library.io';
  /// The condition for a `dart:html` context.
  static const String dartHtmlCondition = 'dart.library.html';

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The prefix to use for the reference.
  String prefix = '';
  /// Whether the library loading should be deferred.
  bool deferred = false;
  /// The names within the library that are shown.
  List<String> shownNames = <String>[];
  /// The names within the library that are hidden.
  List<String> hiddenNames = <String>[];
  Map<String, dynamic> when = <String, dynamic>{};
  /// The library that is being referenced.
  dynamic library;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The library to use for a `dart:io` program.
  dynamic get libraryIo => when[dartIoCondition];
  set libraryIo(dynamic value) {
    when[dartIoCondition] = value;
  }

  /// The library to use for a `dart:html` program.
  dynamic get libraryHtml => when[dartHtmlCondition];
  set libraryHtml(dynamic value) {
    when[dartHtmlCondition] = value;
  }

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    if (shownNames.isNotEmpty && hiddenNames.isNotEmpty) {
      throw new InvalidMetadataError('Uri reference cannot both hide and show names');
    }

    // Verify that a prefix is present when using deferred
    if ((deferred) && (prefix.isEmpty)) {
      throw new UnsupportedError('prefix is mandatory for deferred libraries');
    }
  }

  @override
  UriReferencedMetadata buildInternal() {
    // Build the when conditions
    final whenConditions = <String, LibraryMetadata>{};

    when.forEach((key, value) {
      whenConditions[key] = _buildLibrary(value);
    });

    return new UriReferencedMetadata(
        prefix: prefix,
        deferred: deferred,
        shownNames: shownNames,
        hiddenNames: hiddenNames,
        library: _buildLibrary(library),
        when: whenConditions,
    );
  }

  //---------------------------------------------------------------------
  // Private static methods
  //---------------------------------------------------------------------

  /// Gets library metadata from the [value].
  static LibraryMetadata _buildLibrary(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is LibraryMetadataBuilder) {
        return value.build();
    } else if (value is LibraryMetadata) {
        return value;
    } else {
        throw new InvalidMetadataError('The value is not library metadata');
    }
  }
}

UriReferencedMetadataBuilder uriReferenced() =>
    new UriReferencedMetadataBuilder();
