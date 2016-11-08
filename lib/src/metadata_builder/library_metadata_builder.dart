// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'class_metadata_builder.dart';
import 'field_metadata_builder.dart';
import 'function_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'uri_referenced_metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [LibraryMetadata].
class LibraryMetadataBuilder extends MetadataBuilder<LibraryMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The location of the library.
  Uri uri;
  /// The import references for the library.
  List<UriReferencedMetadataBuilder> imports;
  /// The export references for the library.
  List<UriReferencedMetadataBuilder> exports;
  /// The classes contained within the library.
  List<ClassMetadataBuilder> classes;
  /// The functions contained within the library.
  List<FunctionMetadataBuilder> functions;
  /// The fields contained within the library.
  List<FieldMetadataBuilder> fields;

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
  }

  @override
  LibraryMetadata buildInternal() =>
      new LibraryMetadata(
          uri,
          name: name,
          imports: buildList/*<UriReferencedMetadata>*/(imports),
          exports: buildList/*<UriReferencedMetadata>*/(exports),
          classes: buildList/*<ClassMetadata>*/(classes),
          functions: buildList/*<ClassMetadata>*/(functions),
          fields: buildList/*<ClassMetadata>*/(fields),
          annotations: annotations,
          comments: comments
      );
}

LibraryMetadataBuilder library() => new LibraryMetadataBuilder();
