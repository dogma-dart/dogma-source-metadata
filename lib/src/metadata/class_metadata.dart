// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'abstract_metadata.dart';
import 'annotated_metadata.dart';
import 'constructor_metadata.dart';
import 'enclosing_metadata.dart';
import 'field_metadata.dart';
import 'generic_metadata.dart';
import 'method_metadata.dart';
import 'privacy_metadata.dart';
import 'type_metadata.dart';
import 'typed_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Contains metadata for a class.
class ClassMetadata extends AnnotatedMetadata
                       with PrivacyMetadata,
                            EnclosedMetadata,
                            EnclosingMetadata
                 implements AbstractMetadata,
                            GenericMetadata,
                            TypedMetadata {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  @override
  final TypeMetadata type;
  @override
  final bool isAbstract;
  /// The parent class type.
  final TypeMetadata supertype;
  /// The types this class implements.
  final List<TypeMetadata> interfaces;
  /// The types this class mixins with.
  final List<TypeMetadata> mixins;
  @override
  final List<TypeMetadata> typeParameters;
  /// The fields for the class.
  final List<FieldMetadata> fields;
  /// The methods for the class.
  final List<MethodMetadata> methods;
  /// The constructors for the class.
  final List<ConstructorMetadata> constructors;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [ClassMetadata] with the given [name].
  ///
  /// The class hierarchy can be specified with the [supertype]. Additionally
  /// interfaces that the class conforms to can be specified in [interfaces].
  ///
  /// Currently this implementation is ignoring mixins so this information
  /// is not available to query.
  ClassMetadata(String name,
               {this.supertype,
                this.isAbstract: false,
                List<TypeMetadata> interfaces,
                List<TypeMetadata> mixins,
                List<TypeMetadata> typeParameters,
                List<FieldMetadata> fields,
                List<MethodMetadata> methods,
                List<ConstructorMetadata> constructors,
                List annotations,
                String comments})
      : type = new InterfaceTypeMetadata(name)
      , interfaces = interfaces ?? <TypeMetadata>[]
      , mixins = mixins ?? <TypeMetadata>[]
      , typeParameters = typeParameters ?? <TypeMetadata>[]
      , fields = fields ?? <FieldMetadata>[]
      , methods = methods ?? <MethodMetadata>[]
      , constructors = constructors ?? <ConstructorMetadata>[]
      , super(name, annotations, comments)
  {
    // Use `this` to properly scope the value
    encloseList(this.fields);
    encloseList(this.methods);
    encloseList(this.constructors);
  }
}
