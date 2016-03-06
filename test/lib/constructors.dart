// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

class SyntheticConstructor {}

class DefaultConstructor {
  int value;

  DefaultConstructor(this.value);
}

class NamedConstructor {
  int value;

  NamedConstructor.valued(this.value);
}

class FactoryConstructor {
  int value;

  factory FactoryConstructor.valued(int value) =>
      new FactoryConstructor._(value);

  FactoryConstructor._(this.value);
}

class ConstConstructor {
  final int value;

  const ConstConstructor(this.value);
  const ConstConstructor.foo() : this(3);
  const factory ConstConstructor.bar() = ConstConstructor.foo;
}
