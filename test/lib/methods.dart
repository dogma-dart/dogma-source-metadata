// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

abstract class ClassMethods {
  static void classEmptyMethod() {}
  static String classReturnStringMethod() => 'class-string';

  static void classWithOptionalParamsMethod(String p0, [int p1 = 1, double p2 = 2.0]) {
    print('$p0 $p1 $p2');
  }

  static void classWithNamedParamsMethod(String p0, {int p1: 1, double p2: 2.0}) {
    print('$p0 $p1 $p2');
  }

  void instanceAbstractMethod();
  String instanceReturnStringMethod() => 'instance-string';

  void instanceWithOptionalParamsMethod(String p0, [int p1 = 1, double p2 = 2.0]) {
    print('$p0 $p1 $p2');
  }

  void instanceWithNamedParamsMethod(String p0, {int p1: 1, double p2: 2.0}) {
    print('$p0 $p1 $p2');
  }
}
