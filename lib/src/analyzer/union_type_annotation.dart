// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/element.dart';
import 'package:dogma_union_type/union_type.dart';
import 'package:logging/logging.dart';

import 'annotation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.union_type_annotation');

final ClassMirror _unionTypeMirror =
    classMirror('UnionType', 'dogma_union_type.union_type');

/// Determines if the annotation corresponds to a @UnionType annotation.
dynamic analyzeTypeUnionAnnotation(ElementAnnotationImpl element) {
  print(_unionTypeMirror.declarations);
  var representation = element.element;

  if (representation.enclosingElement.name != 'UnionType') {
    return null;
  }

  if (representation is ConstructorElement) {
    var evaluatedFields = element.evaluationResult.value.fields;

    print(evaluatedFields);
  }
}
