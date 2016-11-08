// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'abstract_metadata.dart';
import 'annotated_metadata.dart';
import 'constant_metadata.dart';
import 'default_metadata.dart';
import 'enclosing_metadata.dart';
import 'privacy_metadata.dart';
import 'static_metadata.dart';
import 'type_metadata.dart';
import 'typed_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a field within a class.
///
/// A field can either be a member variable declaration or a property. This
/// follows the behavior of the analyzer which returns properties as fields on
/// the class.
///
/// This behavior is different from a how dart:mirrors behaves as properties
/// are considered methods and member variables are considered variables.
class FieldMetadata extends AnnotatedMetadata
                       with PrivacyMetadata,
                            EnclosedMetadata
                 implements AbstractMetadata,
                            ConstantMetadata,
                            DefaultMetadata,
                            StaticMetadata,
                            TypedMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final TypeMetadata type;
  @override
  final bool isAbstract;
  @override
  final bool isStatic;
  @override
  final bool isConst;
  /// Whether the field is a property (getter and/or setter).
  final bool isProperty;
  /// Whether the field has a getter.
  final bool getter;
  /// Whether the field has a setter.
  final bool setter;
  /// Whether the field is final.
  final bool isFinal;
  @override
  final dynamic defaultValue;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [FieldMetadata] class with the given [name] of
  /// [type].
  FieldMetadata(String name,
               {TypeMetadata type,
                this.isProperty: false,
                this.getter: true,
                this.setter: true,
                this.isAbstract: false,
                this.isConst: false,
                this.isFinal: false,
                this.isStatic: false,
                this.defaultValue,
                List annotations,
                String comments})
      : type = type ?? dynamicType
      , super(name, annotations, comments);
}
