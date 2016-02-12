// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [LibraryMetadata] class.
library dogma_source_analyzer.src.metadata.library_metadata;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'class_metadata.dart';
import 'field_metadata.dart';
import 'function_metadata.dart';
import 'metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a dart library.
class LibraryMetadata extends Metadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The location of the library.
  final Uri uri;
  /// The libraries imported by the library.
  final List<LibraryMetadata> imported;
  /// The libraries exported by the library.
  final List<LibraryMetadata> exported;
  /// The classes contained within the library.
  final List<ClassMetadata> classes;
  /// The functions contained within the library.
  final List<FunctionMetadata> functions;
  /// The fields contained within the library.
  final List<FieldMetadata> fields;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  LibraryMetadata(String name,
                  this.uri,
                 {List<LibraryMetadata> imported,
                  List<LibraryMetadata> exported,
                  List<ClassMetadata> classes,
                  List<FunctionMetadata> functions,
                  List<FieldMetadata> fields})
      : imported = imported ?? <LibraryMetadata>[]
      , exported = exported ?? <LibraryMetadata>[]
      , classes = classes ?? <ClassMetadata>[]
      , functions = functions ?? <FunctionMetadata>[]
      , fields = fields ?? <FieldMetadata>[]
      , super(name);
}
