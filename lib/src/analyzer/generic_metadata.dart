// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';

import '../../metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

List<TypeMetadata> genericTypeMetadataList(List<TypeParameterElement> typeParameters) {
  final values = <TypeMetadata>[];

  for (var parameter in typeParameters) {
    values.add(genericTypeMetadata(parameter));
  }

  return values;
}

TypeMetadata genericTypeMetadata(TypeParameterElement element) =>
    typeMetadata(element.type);
