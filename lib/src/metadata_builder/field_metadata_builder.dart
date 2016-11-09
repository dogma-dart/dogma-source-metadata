// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'abstract_metadata_builder.dart';
import 'constant_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'typed_metadata_builder.dart';
import 'static_metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [FieldMetadata].
class FieldMetadataBuilder extends MetadataBuilder<FieldMetadata>
                              with AbstractMetadataBuilder,
                                   ConstantMetadataBuilder,
                                   StaticMetadataBuilder,
                                   TypedMetadataBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether the field is a property (getter and/or setter).
  bool isProperty = false;
  /// Whether the field has a getter.
  bool getter = true;
  /// Whether the field has a setter.
  bool setter = true;
  /// Whether the field is final.
  bool isFinal = false;
  /// The default value of the field.
  ///
  /// This is used to write out any initialization of the field.
  dynamic defaultValue;

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

    if (setter && (isConst || isFinal)) {
      throw new InvalidMetadataError('A const or final field does not have a getter');
    }
  }

  @override
  FieldMetadata buildInternal() =>
      new FieldMetadata(
          name,
          type: this.type,
          isProperty: isProperty,
          getter: getter,
          setter: setter,
          isAbstract: isAbstract,
          isConst: isConst,
          isFinal: isFinal,
          isStatic: isStatic,
          defaultValue: defaultValue,
          annotations: annotations,
          comments: comments
      );
}

///
///     int aField;
FieldMetadataBuilder field(String name) =>
    new FieldMetadataBuilder()
        ..name = name;

///
///     const int aField = 1;
FieldMetadataBuilder constField(String name) =>
    field(name)
        ..isConst = true
        ..setter = false;

///
///     final int aField = 1;
FieldMetadataBuilder finalField(String name) =>
    field(name)
        ..isFinal = true
        ..setter = false;

///
///     int get aProperty => ...;
///     set aProperty(int value) { ... }
FieldMetadataBuilder property(String name) =>
    new FieldMetadataBuilder()
        ..name = name
        ..isProperty = true;

///
///    int get aProperty => ...;
FieldMetadataBuilder getter(String name) =>
    property(name)
        ..setter = false;

///
///    set aProperty(int value) { ... }
FieldMetadataBuilder setter(String name) =>
    property(name)
        ..getter = false;
