// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:meta/meta.dart';

import '../../metadata.dart';
import 'invalid_metadata_error.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Base class for a builder.
abstract class MetadataBuilder<T extends Metadata> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The list of annotations.
  List annotations = [];
  /// The documentation comments describing the API.
  String comments = '';
  /// The name associated with this metadata.
  String name = '';

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Creates an instance of the [Metadata] type.
  ///
  /// Before creating the instance the values within the builder are validated.
  T build() {
    validate();

    return buildInternal();
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  /// Validates the metadata being built.
  @protected
  void validate() {
    if (name.isEmpty) {
      throw new InvalidMetadataError('Metadata has no name');
    }
  }

  /// Creates the [Metadata] instance.
  T buildInternal();
}

/// Builds a list of [MetadataBuilder]s.
List/*<T>*/ buildList/*<T extends Metadata>*/(Iterable<MetadataBuilder/*<T>*/> builders) =>
    builders.map/*<T>*/((value) => value.build()).toList();
