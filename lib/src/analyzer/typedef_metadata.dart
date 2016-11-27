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
new Logger('dogma_source_metadata.src.analyzer.typedef_metadata');

/// Creates metadata for the given constructor [element].
TypedefMetadataBuilder typedefMetadata(FunctionTypeAliasElement element,
                                       List<AnalyzeAnnotation> annotationGenerators) {
  final builder = functionMetadata(
      element,
      annotationGenerators,
      new TypedefMetadataBuilder()
  ) as TypedefMetadataBuilder;

  _logTypedef(builder);

  return builder;
}

/// Logs information on the typedef metadata [builder].
void _logTypedef(TypedefMetadataBuilder builder) {
  _logger.fine('Found typedef ${builder.name}');
}
