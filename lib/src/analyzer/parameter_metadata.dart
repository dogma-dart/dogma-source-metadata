// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/element.dart';
import 'package:analyzer/src/generated/utilities_dart.dart' as utilities;
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

List<ParameterMetadata> parameterList(ExecutableElement element,
                                      List<AnalyzeAnnotation> annotationGenerators) {
  var values = <ParameterMetadata>[];

  for (var parameter in element.parameters) {
    values.add(parameterMetadata(parameter, annotationGenerators));
  }

  return values;
}

/// Creates metadata for the given parameter [element].
ParameterMetadata parameterMetadata(ParameterElement element,
                                    List<AnalyzeAnnotation> annotationGenerators) {
  var annotations = createAnnotations(element, annotationGenerators);
  var name = element.name;
  var type = typeMetadata(element.type, annotations);

  _logger.fine('Found parameter $name of type ${type.name}');

  var kind = parameterKind(element.parameterKind);

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
      defaultValue: defaultValue
  );
}

/// Determines what kind of parameter the [value] refers to.
///
/// The analyzer uses string values to denote the different kind of parameters.
/// These match to the following strings.
///
/// * [ParameterKind.name] == 'NAMED'
/// * [ParameterKind.optional] == 'POSITIONAL'
/// * [ParameterKind.required] == 'REQUIRED'
ParameterKind parameterKind(utilities.ParameterKind value) {
  if (value == utilities.ParameterKind.NAMED) {
    return ParameterKind.named;
  } else if (value == utilities.ParameterKind.POSITIONAL) {
    return ParameterKind.positional;
  } else {
    return ParameterKind.required;
  }
}
