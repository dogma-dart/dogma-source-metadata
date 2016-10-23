// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'metadata_builder.dart';
import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Validates that all the [builders] contain unique names.
void validateUniqueNames(Iterable<MetadataBuilder> builders) {
  final names = <String>[];

  for (var builder in builders) {
    final name = builder.name;
    final repeat = names.firstWhere(
        (value) => value == name,
        orElse: () => null
    );

    if (repeat != null) {
      throw new InvalidMetadataError('The name $name is not unique');
    }

    names.add(name);
  }
}
