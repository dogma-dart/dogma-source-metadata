// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'abstract_metadata_builder.dart';
import 'constructor_metadata_builder.dart';
import 'field_metadata_builder.dart';
import 'invalid_metadata_error.dart';
import 'metadata_builder.dart';
import 'method_metadata_builder.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A [MetadataBuilder] for [ClassMetadata].
class ClassMetadataBuilder extends MetadataBuilder<ClassMetadata>
                              with AbstractMetadataBuilder {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The parent class type.
  TypeMetadata supertype;
  /// The types this class implements.
  List<TypeMetadata> interfaces = <TypeMetadata>[];
  /// The types this class mixins with.
  List<TypeMetadata> mixins = <TypeMetadata>[];
  /// The type parameters for the class.
  List<TypeMetadata> typeParameters = <TypeMetadata>[];
  /// The fields for the class.
  List<FieldMetadataBuilder> fields = <FieldMetadataBuilder>[];
  /// The methods for the class.
  List<MethodMetadataBuilder> methods = <MethodMetadataBuilder>[];
  /// The constructors for the class.
  List<ConstructorMetadataBuilder> constructors = <ConstructorMetadataBuilder>[];

  //---------------------------------------------------------------------
  // MetadataBuilder
  //---------------------------------------------------------------------

  @override
  void validate() {
    super.validate();

  }

  @override
  ClassMetadata buildInternal() {
    // For classes which declare no constructors there is always an implicit
    // one created by the analyzer. This mirrors this behavior.
    final classConstructors = constructors.isNotEmpty
        ? constructors
        : <ConstructorMetadataBuilder>[defaultConstructor()];

    // Set the type on all the constructors to be the class name
    //
    // The return type also includes the type parameters for the class.
    final classType = interfaceType(name, typeParameters);
    for (var constructor in classConstructors) {
      constructor.returnType = classType;
    }

    return new ClassMetadata(
        name,
        supertype: supertype,
        interfaces: interfaces,
        mixins: mixins,
        typeParameters: typeParameters,
        fields: buildList<FieldMetadata>(fields),
        methods: buildList<MethodMetadata>(methods),
        constructors: buildList<ConstructorMetadata>(classConstructors),
        annotations: annotations,
        comments: comments
    );
  }
}

/// Creates an instance of [ClassMetadataBuilder] with the given [name].
ClassMetadataBuilder clazz(String name) =>
    new ClassMetadataBuilder()
        ..name = name;
