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
    new Logger('dogma_source_metadata.src.analyzer.constructor_metadata');

/// Creates metadata for the given constructor [element].
ConstructorMetadataBuilder constructorMetadata(ConstructorElement element,
                                               List<AnalyzeAnnotation> annotationGenerators) {
  final builder = functionMetadata(
      element,
      annotationGenerators,
      new ConstructorMetadataBuilder()
  ) as ConstructorMetadataBuilder;

  builder
      ..isFactory = element.isFactory
      ..isConst = element.isConst;

  _logConstructor(builder);

  return builder;
}

/// Logs information on the constructor metadata [builder].
void _logConstructor(ConstructorMetadataBuilder builder) {
  final name = builder.name;

  if (name.isEmpty) {
    _logger.fine('Found default constructor');
  } else {
    _logger.fine('Found named constructor $name');
  }

  final isFactory = builder.isFactory;

  if (isFactory) {
    _logger.finer('Constructor is a factory');
  }

  final isConst = builder.isConst;

  if (isConst) {
    _logger.finer('Constructor is const');
  }
}
