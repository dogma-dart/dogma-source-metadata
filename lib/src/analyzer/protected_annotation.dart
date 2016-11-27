// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_metadata.src.analyzer.protected_annotation');

/// Determines if the annotation corresponds to a @protected annotation.
dynamic analyzeProtectedAnnotation(ElementAnnotation element) {
  if (element.isProtected) {
    _logger.fine('Found protected annotation');

    return protected;
  } else {
    return null;
  }
}
