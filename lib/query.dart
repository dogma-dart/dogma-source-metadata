// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Provides a way to query [Metadata].
///
/// The library contains only commonly used searches. If a particular search
/// is not present then it can easily be created.
///
/// Metadata can be queried by creating a [MetadataMatchFunction]. It is a
/// simple function that takes in a [Metadata] and then returns a boolean
/// dependent on whether the metadata passed in matches.
///
/// A simple example that matches all functions with two parameters follows.
///
///     import 'package:dogma_source_metadata/analyzer.dart';
///     import 'package:dogma_source_metadata/search.dart';
///
///     bool _twoParameterFunctions(Metadata metadata) =>
///         ((metadata is FunctionMetadata) && (metadata.parameters.length == 2));
///
///     void main() {
///       var context = analysisContext();
///       var library = libraryMetadata(Uri.parse('package:foo/foo.dart'), context);
///
///       var functionQuery = libraryMetadataQueryAll(
///           library,
///           _twoParameterFunctions,
///           includeFunctions: true
///       );
///
///       for (var function in functionQuery) {
///         print('${function.name} has two parameters');
///       }
///     }
///
/// This could be further expanded by taking a variable number of parameters.
///
///     MetadataMatchFunction _nParameterFunctions(int count) =>
///         (metadata) => (
///             (metadata is FunctionMetadata) &&
///             (metadata.parameters.length == count)
///         );
///
/// Boolean operations can also be added for [and]-ing, [or]-ing, or negating,
/// [not], functions together to form longer queries.
///
/// The following code gets all functions that do not have a parameter length
/// of three.
///
///     var functionQuery = libraryMetadataQueryAll(
///         library,
///         not(_nParameterFunctions(3))
///         includeFunctions: true
///     );
library dogma_source_metadata.query;

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/query/class_metadata.dart';
export 'src/query/library_metadata.dart';
