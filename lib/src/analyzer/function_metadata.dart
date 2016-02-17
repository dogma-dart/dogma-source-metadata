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
FunctionMetadata functionMetadata(FunctionElement element) {
  var annotations = createAnnotations(element, []);
  var comments = elementComments(element);

  var name = element.name;
  var parameters = parameterList(element);
  var isPrivate = element.isPrivate;
  var returnType = typeMetadata(element.returnType);

  _logger.fine('Found function $name');

  return new FunctionMetadata(
      name,
      returnType,
      parameters: parameters,
      isPrivate: isPrivate,
      annotations: annotations,
      comments: comments
  );
}