// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_metadata.src.analyzer.deprectated_annotation');

/// Determines if the annotation corresponds to a @deprecated annotation.
dynamic analyzeDeprecatedAnnotation(ElementAnnotation element) {
  if (element.isDeprecated) {
    _logger.fine('Found deprecated annotation');

    return deprecated;
  } else {
    return null;
  }
}
