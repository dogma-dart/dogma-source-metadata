// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'invalid_metadata_error.dart';
import 'field_metadata_builder.dart';
import 'metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [EnumMetadata].
///
/// The [EnumMetadataBuilder] does the following validations.
///
/// * The parameter must have a name.
/// * A default value is not valid for a required parameter.
class EnumMetadataBuilder extends MetadataBuilder<EnumMetadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The list of values for the enumeration.
  List<FieldMetadataBuilder> values = <FieldMetadataBuilder>[];

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

    if (values.isEmpty) {
      throw new InvalidMetadataError('Enumeration has no values');
    }
  }

  @override
  EnumMetadata buildInternal() {
    // Set the type for the individual enumerations
    final count = values.length;
    final enumType = interfaceType(name);

    for (var i = 0; i < count; ++i) {
      values[i]
          ..type = enumType
          ..defaultValue = i;
    }

    // Within the analyzer an enum only has fields.
    //
    // Add an index field and the values field.
    final fields = <FieldMetadataBuilder>[
      finalField('index')
          ..type = intType,
      constField('values')
          ..type = listType(enumType)
          ..isStatic = true
    ]..addAll(values);

    return new EnumMetadata(
        name,
        buildList/*<FieldMetadata>*/(fields),
        annotations: annotations,
        comments: comments
    );
  }
}

EnumMetadataBuilder enumeration(String name) =>
    new EnumMetadataBuilder()
        ..name = name;

FieldMetadataBuilder enumValue(String name) =>
    new FieldMetadataBuilder()
        ..name = name
        ..isStatic = true
        ..isConst = true;

EnumMetadataBuilder enumerations(String name, List<String> values) {
  final clazz = enumeration(name);

  for (var value in values) {
    clazz.values.add(enumValue(value));
  }

  return clazz;
}
