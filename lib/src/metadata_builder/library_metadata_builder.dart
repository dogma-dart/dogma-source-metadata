// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'class_metadata_builder.dart';
import 'enum_metadata_builder.dart';
import 'field_metadata_builder.dart';
import 'function_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'typedef_metadata_builder.dart';
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
  List<UriReferencedMetadataBuilder> imports = <UriReferencedMetadataBuilder>[];
  /// The export references for the library.
  List<UriReferencedMetadataBuilder> exports = <UriReferencedMetadataBuilder>[];
  /// The classes contained within the library.
  List<ClassMetadataBuilder> classes = <ClassMetadataBuilder>[];
  /// The enumerations contained within the library.
  List<EnumMetadataBuilder> enums = <EnumMetadataBuilder>[];
  /// The functions contained within the library.
  List<FunctionMetadataBuilder> functions = <FunctionMetadataBuilder>[];
  /// The fields contained within the library.
  List<FieldMetadataBuilder> fields = <FieldMetadataBuilder>[];
  /// The function type definitions contained within the library.
  List<TypedefMetadataBuilder> typedefs = <TypedefMetadataBuilder>[];

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
          classes:
              buildList/*<ClassMetadata>*/(classes)
                  ..addAll(buildList/*<ClassMetadata>*/(enums)),
          functions: buildList/*<FunctionMetadata>*/(functions),
          fields: buildList/*<FieldMetadata>*/(fields),
          typedefs: buildList/*<TypedefMetadata>*/(typedefs),
          annotations: annotations,
          comments: comments
      );
}

LibraryMetadataBuilder library() => new LibraryMetadataBuilder();
