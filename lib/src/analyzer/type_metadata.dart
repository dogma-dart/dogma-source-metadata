// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/type.dart';
import 'package:dogma_union_type/union_type.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.type_metadata');

/// Creates type metadata from the given [type].
///
/// A list of [annotations] can be provided which will be searched for union
/// type annotations.
TypeMetadata typeMetadata(DartType type,
                         [List annotations]) {
  var unionType = _unionType(annotations);
  var name = type.name;
  var value;

  if (unionType != null) {
    _logger.fine('Explicit union type found on field. ${unionType.types.toString()}');

    if (name != 'dynamic') {
      throw new ArgumentError.value(type, 'Is using a UnionType and is not dynamic');
    }

    value = new TypeMetadata(name);
  } else {
    var arguments = <TypeMetadata>[];

    if (type is InterfaceType) {
      for (var argument in type.typeArguments) {
        _logger.fine('Found type argument ${argument.name}');
        arguments.add(typeMetadata(argument));
      }
    }

    value = new TypeMetadata(name, arguments: arguments);
  }

  return value;
}

/// Retrieve the [UnionType] from the list of [annotations].
///
/// If a [UnionType] is not found then `null` is returned.
UnionType _unionType(List annotations) =>
    annotations == null
        ? null
        : annotations.firstWhere((value) => value is UnionType, orElse: () => null);
