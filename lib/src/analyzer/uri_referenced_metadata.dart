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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_metadata.src.analyzer.uri_reference_metadata');

/// Creates a list of uri reference metadata from the given [elements].
List<UriReferencedMetadataBuilder> uriReferenceList(Iterable<UriReferencedElement> elements) {
  final references = <UriReferencedMetadataBuilder>[];

  for (var element in elements) {
    references.add(uriReferenceMetadata(element));
  }

  return references;
}

/// Creates metadata for the given reference [element].
UriReferencedMetadataBuilder uriReferenceMetadata(UriReferencedElement element) {
  final builder = new UriReferencedMetadataBuilder();
  var combinators;

  if (element is ImportElement) {
    builder.prefix = element.prefix?.name ?? '';
    builder.deferred = element.isDeferred;

    combinators = element.combinators;
  } else if (element is ExportElement) {
    combinators = element.combinators;
  } else {
    throw new ArgumentError.value(element, 'Element is not an import or export statement');
  }

  for (var combinator in combinators) {
    if (combinator is ShowElementCombinator) {
      builder.shownNames = combinator.shownNames;
    } else if (combinator is HideElementCombinator) {
      builder.hiddenNames = combinator.hiddenNames;
    }
  }

  return builder;
}
