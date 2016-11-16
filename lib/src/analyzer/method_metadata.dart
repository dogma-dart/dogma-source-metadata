// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../../metadata_builder.dart';
import 'annotation.dart';
import 'function_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.method_metadata');

/// Creates metadata for the given method [element].
MethodMetadataBuilder methodMetadata(MethodElement element,
                                     List<AnalyzeAnnotation> annotationGenerators) {
  final builder = functionMetadata(
      element,
      annotationGenerators,
      new MethodMetadataBuilder()
  ) as MethodMetadataBuilder;

  builder
      ..isAbstract = element.isAbstract
      ..isStatic = element.isStatic;

  _logMethod(builder);

  return builder;
}

/// Logs information on the method metadata [builder].
void _logMethod(MethodMetadataBuilder builder) {
  _logger.fine('Found method ${builder.name}');

  final isAbstract = builder.isAbstract;

  if (isAbstract) {
    _logger.finer('Method is abstract');
  }

  final isStatic = builder.isStatic;

  if (isStatic) {
    _logger.finer('Method is static');
  }
}
