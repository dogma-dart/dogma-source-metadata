// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma_source_metadata.test.lib.mirrors;

class A {
  final int value;

  A(this.value);

  A._()
     : value = defaultValue;

  static int defaultValue = 2;
}

void function() { print('Im a function'); }
