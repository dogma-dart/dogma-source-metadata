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
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.parameter_metadata');

List<ParameterMetadata> parameterList(ExecutableElement element) {
  var values = <ParameterMetadata>[];

  for (var parameter in element.parameters) {
    values.add(parameterMetadata(parameter));
  }

  return values;
}

/// Creates metadata for the given parameter [element].
ParameterMetadata parameterMetadata(ParameterElement element) {
  var annotations = createAnnotations(element, []);
  var name = element.name;
  var type = typeMetadata(element.type);

  _logger.fine('Found parameter $name of type ${type.name}');

  return new ParameterMetadata(
      name,
      type,
      parameterKind: parameterKind(element.parameterKind.name),
      annotations: annotations
  );
}

/// Determines what kind of parameter the [value] refers to.
///
/// The analyzer uses string values to denote the different kind of parameters.
/// These match to the following strings.
///
/// * [ParameterKind.name] == 'NAMED'
/// * [ParameterKind.optional] == 'OPTIONAL'
/// * [ParameterKind.required] == 'REQUIRED'
ParameterKind parameterKind(String value) {
  if (value == 'NAMED') {
    return ParameterKind.named;
  } else if (value == 'OPTIONAL') {
    return ParameterKind.optional;
  } else {
    return ParameterKind.required;
  }
}
