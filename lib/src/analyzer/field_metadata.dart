// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/element.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';
import 'annotation.dart';
import 'comments.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.field_metadata');

FieldMetadata fieldMetadata(FieldElement element) {
  var name = element.name;

  // Get the annotations
  var annotations = createAnnotations(element, []);
  var comments = elementComments(element);

  // Get the type
  var type = typeMetadata(element.type, annotations);

  // Get whether the field is a property
  var isFinal = element.isFinal;
  var isConst = element.isConst;
  var isProperty;
  var getter;
  var setter;

  if (element.isSynthetic) {
    isProperty = true;
    getter = element.getter != null;
    setter = element.setter != null;

    _logger.fine('Field $name is a property. Getter : $getter Setter: $setter');
  } else {
    isProperty = false;
    getter = true;

    // If the field is final or const it is not possible to set the value
    setter = !(isFinal || isConst);

    _logger.fine('Field $name is a field.');
  }

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
      annotations: annotations,
      comments: comments
  );
}
