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

MetadataMatchFunction not(MetadataMatchFunction function) =>
    (metadata) => !function(metadata);

MetadataMatchFunction and(MetadataMatchFunction a, MetadataMatchFunction b) =>
    (metadata) => a(metadata) && b(metadata);

MetadataMatchFunction or(MetadataMatchFunction a, MetadataMatchFunction b) =>
    (metadata) => a(metadata) || b(metadata);

MetadataMatchFunction andList(List<MetadataMatchFunction> functions) =>
    (metadata) {
      for (var function in functions) {
        if (!function(metadata)) {
          return false;
        }
      }

      return true;
    };

MetadataMatchFunction orList(List<MetadataMatchFunction> functions) =>
    (metadata) {
      for (var function in functions) {
        if (function(metadata)) {
          return true;
        }
      }

      return false;
    };
