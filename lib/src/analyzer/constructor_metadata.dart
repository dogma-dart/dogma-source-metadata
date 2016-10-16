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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.constructor_metadata');

/// Creates metadata for the given constructor [element].
ConstructorMetadata constructorMetadata(ConstructorElement element,
                                        TypeMetadata returnType,
                                        List<AnalyzeAnnotation> annotationGenerators) {
  final annotations = createAnnotations(element, annotationGenerators);
  final comments = elementComments(element);

  final name = element.name;
  final parameters = parameterList(element, annotationGenerators);
  final isPrivate = element.isPrivate;
  final isFactory = element.isFactory;
  final isConst = element.isConst;

  if (name.isEmpty) {
    _logger.fine('Found default constructor');

    return new ConstructorMetadata(
        returnType,
        parameters: parameters,
        isPrivate: isPrivate,
        isFactory: isFactory,
        isConst: isConst,
        annotations: annotations,
        comments: comments
    );
  } else {
    _logger.fine('Found named constructor $name');

    return new ConstructorMetadata.named(
        name,
        returnType,
        parameters: parameters,
        isPrivate: isPrivate,
        isFactory: isFactory,
        isConst: isConst,
        annotations: annotations,
        comments: comments
    );
  }
}
