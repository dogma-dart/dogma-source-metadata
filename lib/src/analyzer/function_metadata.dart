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
import 'parameter_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.function_metadata');

/// Creates metadata for the given function [element].
FunctionMetadataBuilder functionMetadata(FunctionTypedElement element,
                                         List<AnalyzeAnnotation> annotationGenerators,
                                        [FunctionMetadataBuilder builder]) {
  // If builder is null then the call is coming from a different function
  // and logging should not be outputted in this context
  final log = builder == null;

  // Create a builder if necessary
  builder ??= new FunctionMetadataBuilder();

  builder
      ..name = element.name
      ..annotations = createAnnotations(element, annotationGenerators)
      ..comments = elementComments(element)
      ..returnType = typeMetadata(element.returnType)
      ..parameters = parameterList(element, annotationGenerators);

  if (log) {
    _logFunction(builder);
  }

  return builder;
}

/// Logs information on the function metadata [builder].
void _logFunction(FunctionMetadataBuilder builder) {
  _logger.fine('Found function ${builder.name}');
}
