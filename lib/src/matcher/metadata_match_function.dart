// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Function signature for a function that takes some [metadata] and returns
/// `true` if it matches some criteria and `false` otherwise.
typedef bool MetadataMatchFunction(Metadata metadata);

/// Negates the result of the [function].
MetadataMatchFunction not(MetadataMatchFunction function) =>
    (metadata) => !function(metadata);

/// Combines the functions in [a] and [b] into an and statement.
///
/// For the value to be `true` both [a] and [b] need to be `true`. If either of
/// the functions return `false` then `false` will be returned.
MetadataMatchFunction and(MetadataMatchFunction a, MetadataMatchFunction b) =>
    (metadata) => a(metadata) && b(metadata);

/// Combines the functions in [a] and [b] into an or statement.
///
/// For the value to be `false` both [a] and [b] need to be `false`. If either
/// of the functions return `true` then `true` will be returned.
MetadataMatchFunction or(MetadataMatchFunction a, MetadataMatchFunction b) =>
    (metadata) => a(metadata) || b(metadata);

/// Combines a list of [functions] into an and statement.
///
/// This function acts like the following code.
///
///     functions[0] && functions[1] && ... functions[n-2] && functions[n-1]
MetadataMatchFunction andList(List<MetadataMatchFunction> functions) =>
    (metadata) {
      for (var function in functions) {
        if (!function(metadata)) {
          return false;
        }
      }

      return true;
    };

/// Combines a list of [functions] into an or statement.
///
/// This function acts like the following code.
///
///     functions[0] || functions[1] || ... functions[n-2] || functions[n-1]
MetadataMatchFunction orList(List<MetadataMatchFunction> functions) =>
    (metadata) {
      for (var function in functions) {
        if (function(metadata)) {
          return true;
        }
      }

      return false;
    };
