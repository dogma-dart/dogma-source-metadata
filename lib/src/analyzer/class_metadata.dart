// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/src/generated/element.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';
import 'field_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.class_metadata');

ClassMetadata classMetadata(ClassElement element) {
  var name = element.name;
  _logger.info('Creating metadata for class $name');

  var fields = <FieldMetadata>[];

  // Iterate over the fields
  for (var field in element.fields) {
    var fieldName = field.name;
    _logger.fine('Found field $fieldName on $name');
    fields.add(fieldMetadata(field));
  }

  var supertypeName = element.supertype.name;

  if (supertypeName != 'Object') {
    _logger.fine('Found that $name extends $supertypeName');
  } else {
    _logger.fine('Found that $name extends Object');
  }

  for (var mixin in element.mixins) {
    var mixinName = mixin.name;
    _logger.fine('Found that $name mixes in $mixinName');
  }

  for (var interface in element.interfaces) {
    var interfaceName = interface.name;
    _logger.fine('Found that $name implements $interfaceName');
  }

  return new ClassMetadata(name, fields: fields);
}
