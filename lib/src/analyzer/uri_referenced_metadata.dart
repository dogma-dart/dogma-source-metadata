// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.uri_reference_metadata');

/// Creates a list of uri reference metadata from the given [elements].
List<UriReferencedMetadata> uriReferenceList(Iterable<UriReferencedElement> elements) {
  var references = <UriReferencedMetadata>[];

  for (var element in elements) {
    references.add(uriReferenceMetadata(element));
  }

  return references;
}

/// Creates metadata for the given reference [element].
UriReferencedMetadata uriReferenceMetadata(UriReferencedElement element) {
  var prefix;
  var combinators;

  if (element is ImportElement) {
    _logger.fine('Found import of ${element.uri}');
    var prefixElement = element.prefix;

    if (prefixElement != null) {
      prefix = prefixElement.name;
      _logger.fine('Import uses prefix $prefix');
    }

    combinators = element.combinators;
  } else if (element is ExportElement) {
    _logger.fine('Found export of ${element.uri}');
    combinators = element.combinators;
  } else {
    throw new ArgumentError.value(element, 'Element is not an import or export statement');
  }

  var shownNames;
  var hiddenNames;

  for (var combinator in combinators) {
    if (combinator is ShowElementCombinator) {
      shownNames = combinator.shownNames;
      _logger.fine('Only ${shownNames.join(',')} shown');
    } else if (combinator is HideElementCombinator) {
      hiddenNames = combinator.hiddenNames;
      _logger.fine('Values ${hiddenNames.join(',')} hidden)');
    }
  }

  return new UriReferencedMetadata(
      prefix: prefix,
      shownNames: shownNames as List<String>,
      hiddenNames: hiddenNames as List<String>
  );
}
