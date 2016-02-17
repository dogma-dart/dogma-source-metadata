// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Test entry point.
void main() {
  test('property test', () {
    var required = new ParameterMetadata(
        'required',
        new TypeMetadata.bool(),
        parameterKind: ParameterKind.required
    );

    expect(required.parameterKind, ParameterKind.required);
    expect(required.isOptional, false);
    expect(required.isRequired, true);

    var optional = new ParameterMetadata(
        'optional',
        new TypeMetadata.bool(),
        parameterKind: ParameterKind.optional
    );

    expect(optional.parameterKind, ParameterKind.optional);
    expect(optional.isOptional, true);
    expect(optional.isRequired, false);

    var named = new ParameterMetadata(
        'optional',
        new TypeMetadata.bool(),
        parameterKind: ParameterKind.named
    );

    expect(named.parameterKind, ParameterKind.named);
    expect(named.isOptional, true);
    expect(named.isRequired, false);
  });
}
