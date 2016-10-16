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
import 'annotation.dart';
import 'constant_object.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.parameter_metadata');

/// Creates a list of parameter metadata for the given executable [element].
List<ParameterMetadata> parameterList(ExecutableElement element,
                                      List<AnalyzeAnnotation> annotationGenerators) {
  final values = <ParameterMetadata>[];

  for (var parameter in element.parameters) {
    values.add(parameterMetadata(parameter, annotationGenerators));
  }

  return values;
}

/// Creates metadata for the given parameter [element].
ParameterMetadata parameterMetadata(ParameterElement element,
                                    List<AnalyzeAnnotation> annotationGenerators) {
  final annotations = createAnnotations(element, annotationGenerators);
  final name = element.name;
  final type = typeMetadata(element.type, annotations);

  _logger.fine('Found parameter $name of type ${type.name}');

  final kind = parameterKind(element.parameterKind);

  _logger.finer('Parameter is ${kind.toString().split('.')[1]}');

  var defaultValue = element.constantValue;

  if (defaultValue != null) {
    defaultValue = dartValue(defaultValue);

    _logger.finer('Parameter has default value of $defaultValue');
  }

  return new ParameterMetadata(
      name,
      type,
      parameterKind: parameterKind(element.parameterKind),
      annotations: annotations,
      isInitializer: element.isInitializingFormal,
      defaultValue: defaultValue
  );
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
