// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'class_metadata.dart';
import 'field_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Metadata for an enumeration.
class EnumMetadata extends ClassMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The enumeration values.
  final List<FieldMetadata> values;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  /// Creates an instance of [EnumMetadata] with the given [name] and [fields].
  factory EnumMetadata(String name,
                       List<FieldMetadata> fields,
                      {List annotations,
                       String comments}) {
    var fieldValues = fields.where((value) => value.type.name == name).toList();
    fieldValues.sort((a, b) => a.defaultValue - b.defaultValue);

    return new EnumMetadata._(name, fieldValues, annotations, comments);
  }

  EnumMetadata._(String name,
                 List<FieldMetadata> values,
                 List annotations,
                 String comments)
      : values = values
      , super(name, fields: values, annotations: annotations, comments: comments);
}
