// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/analyzer.dart' as analyzer;
import 'package:logging/logging.dart';

import '../../metadata.dart';
import '../../metadata_builder.dart';
import 'annotation.dart';
import 'constant_object.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_metadata.src.analyzer.parameter_metadata');

/// Creates a list of parameter metadata builders for the given executable
/// [element].
List<ParameterMetadataBuilder> parameterList(FunctionTypedElement element,
                                             List<AnalyzeAnnotation> annotationGenerators) =>
    element.parameters.map/*<ParameterMetadataBuilder>*/(
        (value) => parameterMetadata(value, annotationGenerators)
    ).toList();

/// Creates metadata for the given parameter [element].
ParameterMetadataBuilder parameterMetadata(ParameterElement element,
                                           List<AnalyzeAnnotation> annotationGenerators) {
  final builder = new ParameterMetadataBuilder()
      ..name = element.name
      ..annotations = createAnnotations(element, annotationGenerators)
      ..type = typeMetadata(element.type)
      ..parameterKind = parameterKind(element.parameterKind)
      ..isInitializer = element.isInitializingFormal
      ..defaultValue = dartValue(element.constantValue);

  _logParameter(builder);

  return builder;
}

/// Determines what kind of parameter the [value] refers to.
///
/// The analyzer uses string values to denote the different kind of parameters.
/// These match to the following strings.
///
/// * [ParameterKind.named] == 'NAMED'
/// * [ParameterKind.positional] == 'POSITIONAL'
/// * [ParameterKind.required] == 'REQUIRED'
ParameterKind parameterKind(analyzer.ParameterKind value) {
  if (value == analyzer.ParameterKind.NAMED) {
    return ParameterKind.named;
  } else if (value == analyzer.ParameterKind.POSITIONAL) {
    return ParameterKind.positional;
  } else {
    return ParameterKind.required;
  }
}

/// Logs information on the parameter metadata [builder].
void _logParameter(ParameterMetadataBuilder builder) {
  _logger.fine('Found parameter ${builder.name} of type ${builder.type}');
  _logger.finer('Parameter is ${builder.parameterKind.toString().split('.')[1]}');

  if (builder.isInitializer) {
    _logger.finer('Parameter is initializer');
  }

  final defaultValue = builder.defaultValue;

  if (defaultValue != null) {
    _logger.finer('Parameter has default value of $defaultValue');
  }
}
