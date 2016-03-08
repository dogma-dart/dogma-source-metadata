// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../metadata.dart';
import 'metadata_match_function.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matches [metadata] that is an instance of [ConstructorMetadata].
bool constructorMetadataMatch(Metadata metadata) =>
    metadata is ConstructorMetadata;

/// Matches constructor [metadata] that is a default constructor.
bool defaultConstructorMatch(Metadata metadata) =>
    (metadata as ConstructorMetadata).isDefault;

/// Matches constructor [metadata] that is a factory constructor.
bool factoryConstructorMatch(Metadata metadata) =>
    (metadata as ConstructorMetadata).isFactory;

/// Matches constructor [metadata] that is a named constructor.
final MetadataMatchFunction namedConstructorMatch =
    not(defaultConstructorMatch);
