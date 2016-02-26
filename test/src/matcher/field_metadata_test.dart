// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final TypeMetadata _fieldType = new TypeMetadata.int();
final FieldMetadata _instanceField =
    new FieldMetadata.field(
        'instanceField',
        _fieldType,
        isConst: false,
        isFinal: false
    );

void main() {

}
