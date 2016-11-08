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
  // Member variables
  //---------------------------------------------------------------------

  /// The prefix to use for the reference.
  String prefix = '';
  /// The names within the library that are shown.
  List<String> shownNames = <String>[];
  /// The names within the library that are hidden.
  List<String> hiddenNames = <String>[];
  /// The library that is being referenced.
  dynamic _library;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  dynamic get library => _library;
  set library(dynamic value) {
    if ((value is! LibraryMetadata) && (value is! LibraryMetadataBuilder)) {
      throw new UnsupportedError('value must be LibraryMetadata or a LibraryMetadataBuilder');
    }

    _library = value;
  }

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    if (shownNames.isNotEmpty && hiddenNames.isNotEmpty) {
      throw new InvalidMetadataError('Uri reference cannot both hide and show names');
    }
  }

  @override
  UriReferencedMetadata buildInternal() {
    var lib = library;

    if ((lib != null) && (lib is LibraryMetadataBuilder)) {
      lib = lib.build();
    }

    return new UriReferencedMetadata(
        prefix: prefix,
        shownNames: shownNames,
        hiddenNames: hiddenNames
    );
  }
}

UriReferencedMetadataBuilder uriReferenced() =>
    new UriReferencedMetadataBuilder();
