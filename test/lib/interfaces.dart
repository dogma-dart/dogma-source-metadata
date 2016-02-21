// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

class A {
  int a;
}

class B {
  int b;
}

class C {
  int c;
}

class D implements A, B, C {
  @override
  int a;
  @override
  int b;
  @override
  int c;
  @override
  int d;
}
