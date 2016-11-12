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
import 'type_metadata.dart';

import 'constant_object.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.field_metadata');

/// Creates metadata for the given field [element].
///
/// The [PropertyInducingElement] is used instead of [FieldElement] as it is a
/// common base class for [TopLevelVariableElement] which are fields within the
/// library.
FieldMetadata fieldMetadata(PropertyInducingElement element,
                            List<AnalyzeAnnotation> annotationGenerators) {
  final builder = new FieldMetadataBuilder()
      ..name = element.name
      ..comments = elementComments(element)
      ..type = typeMetadata(element.type)
      ..isStatic = element.isStatic;

  // Get whether the field is a property
  final isFinal = element.isFinal;
  final isConst = element.isConst;
  var isAbstract = false;
  var annotations;
  var getter;
  var setter;

  if (element.isSynthetic) {
    builder.isProperty = true;

    final getterElement = element.getter;
    final setterElement = element.setter;

    getter = getterElement != null;
    setter = setterElement != null;

    // Get the annotation on the individual parts
    if (getter) {
      annotations = createAnnotations(getterElement, annotationGenerators);
      isAbstract = getterElement.isAbstract;
    } else {
      annotations = [];
    }

    if (setter) {
      annotations.addAll(createAnnotations(setterElement, annotationGenerators));
      isAbstract = setterElement.isAbstract || isAbstract;
    }
  } else {
    builder
        ..isProperty = false
        ..defaultValue = dartValue(element.constantValue, dartEnumIndex);

    // Field always has a getter
    getter = true;

    // Get the annotation on the element directly
    annotations = createAnnotations(element, annotationGenerators);

    // If the field is final or const it is not possible to set the value
    setter = !(isFinal || isConst);
  }

  builder
      ..getter = getter
      ..setter = setter
      ..isFinal = isFinal
      ..isConst = isConst
      ..isAbstract = isAbstract
      ..annotations = annotations;

  _logField(builder);

  return builder.build();
}

/// Logs information on the field metadata [builder].
void _logField(FieldMetadataBuilder builder) {
  final fieldType = builder.isProperty ? 'property' : 'field';
  _logger.fine('Found ${fieldType} ${builder.name}');
}
