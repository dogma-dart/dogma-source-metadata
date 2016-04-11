// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'constructor_metadata.dart';
import 'class_metadata.dart';
import 'field_metadata.dart';
import 'method_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class EnumMetadata extends ClassMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  final List<FieldMetadata> values;

  //---------------------------------------------------------------------
  // Constructors
  //---------------------------------------------------------------------

  factory EnumMetadata(String name,
                       List<FieldMetadata> fields,
                      {List annotations,
                       String comments}) {
    var fieldValues = fields.where((value) => value.type.name == name).toList();
    fieldValues.sort((a, b) => a.defaultValue - b.defaultValue);

    return new EnumMetadata._(name, fieldValues, annotations, comments);
  }

  EnumMetadata._(String name, this.values, List annotations, String comments)
      : super(name, annotations: annotations, comments: comments);
}
