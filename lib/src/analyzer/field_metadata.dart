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
  var name = element.name;

  // Get the annotations
  var annotations;
  var comments = elementComments(element);

  // Get whether the field is a property
  var isFinal = element.isFinal;
  var isConst = element.isConst;
  var isProperty;
  var getter;
  var setter;
  var defaultValue;

  if (element.isSynthetic) {
    isProperty = true;
    var getterElement = element.getter;
    var setterElement = element.setter;

    getter = getterElement != null;
    setter = setterElement != null;

    // Get the annotation on the individual parts
    annotations = getter
        ? createAnnotations(getterElement, annotationGenerators)
        : [];

    if (setter) {
      annotations.addAll(createAnnotations(setterElement, annotationGenerators));
    }

    _logger.fine('Field $name is a property. Getter : $getter Setter: $setter');
  } else {
    _logger.fine('Field $name is a field.');

    isProperty = false;
    getter = true;

    // Get the annotation on the element directly
    annotations = createAnnotations(element, annotationGenerators);

    // If the field is final or const it is not possible to set the value
    setter = !(isFinal || isConst);

    // See if there is a default value
    var constantValue = element.constantValue;

    if (constantValue != null) {
      defaultValue = dartValue(constantValue, dartEnumIndex);

      _logger.fine('Field value defaults to $defaultValue');
    }
  }

  // Get the type
  //
  // This needs to go after the annotations are computed
  var type = typeMetadata(element.type, annotations);

  return new FieldMetadata(
      element.name,
      type,
      isProperty,
      getter,
      setter,
      isPrivate: element.isPrivate,
      isConst: isConst,
      isFinal: isFinal,
      isStatic: element.isStatic,
      defaultValue: defaultValue,
      annotations: annotations,
      comments: comments
  );
}
