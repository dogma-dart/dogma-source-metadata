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
import 'parameter_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.method_metadata');

/// Creates metadata for the given method [element].
MethodMetadata methodMetadata(MethodElement element,
                              List<AnalyzeAnnotation> annotationGenerators) {
  var annotations = createAnnotations(element, annotationGenerators);
  var comments = elementComments(element);

  var name = element.name;
  var parameters = parameterList(element, annotationGenerators);
  var isPrivate = element.isPrivate;
  var isAbstract = element.isAbstract;
  var returnType = typeMetadata(element.returnType);

  _logger.fine('Found method $name');

  return new MethodMetadata(
      name,
      returnType,
      parameters: parameters,
      isAbstract: isAbstract,
      isPrivate: isPrivate,
      isStatic: element.isStatic,
      annotations: annotations,
      comments: comments
  );
}
