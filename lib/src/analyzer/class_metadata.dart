// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';
import '../../metadata_builder.dart';
import 'annotation.dart';
import 'comments.dart';
import 'constructor_metadata.dart';
import 'field_metadata.dart';
import 'generic_metadata.dart';
import 'method_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.class_metadata');

/// Creates class metadata from the given [element].
MetadataBuilder<ClassMetadata> classMetadata(ClassElement element,
                                             List<AnalyzeAnnotation> annotationCreators) {
  final builder = element.isEnum
      ? _enumMetadata(element, annotationCreators)
      : _classMetadata(element, annotationCreators);

  builder
      ..name = element.name
      ..annotations = createAnnotations(element, annotationCreators)
      ..comments = elementComments(element);

  return builder;
}

MetadataBuilder<EnumMetadata> _enumMetadata(ClassElement element,
                                            List<AnalyzeAnnotation> annotationCreators) {
  final builder = new EnumMetadataBuilder();

  // These are assertions for how the analyzer is currently representing
  // enumerations. This is just meant to catch any changes that are required
  // for the EnumMetadataBuilder to be functioning properly
  assert(element.interfaces.isEmpty);
  assert(element.supertype.name == 'Object');
  assert(element.constructors.isEmpty);

  final name = element.name;

  // Get fields that correspond to enum values
  for (var field in element.fields) {
    if (field.type.name == name) {
      builder.values.add(fieldMetadata(field, annotationCreators));
    }
  }

  // Make sure the values are properly sorted
  //
  // They should already be sorted by the analyzer but there are no guarantees
  // this behavior will be consistent in the future.
  builder.values.sort((a, b) => a.defaultValue - b.defaultValue);

  return builder;
}

MetadataBuilder<ClassMetadata> _classMetadata(ClassElement element,
                                              List<AnalyzeAnnotation> annotationCreators) {
  final builder = new ClassMetadataBuilder()
      ..supertype = typeMetadata(element.supertype)
      ..mixins = typeMetadataList(element.mixins)
      ..interfaces = typeMetadataList(element.interfaces)
      ..typeParameters = genericTypeMetadataList(element.typeParameters)
      ..fields =
          element.fields.map/*<FieldMetadataBuilder>*/(
              (value) => fieldMetadata(value, annotationCreators)
          ).toList()
      ..methods =
          element.methods.map/*<MethodMetadataBuilder>*/(
              (value) => methodMetadata(value, annotationCreators)
          ).toList()
      ..constructors =
          element.constructors.map/*<ConstructorMetadataBuilder>*/(
              (value) => constructorMetadata(value, annotationCreators)
          ).toList();

  return builder;
}
