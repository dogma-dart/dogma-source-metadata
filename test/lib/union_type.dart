// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

import 'package:dogma_union_type/union_type.dart';

class Unionized {
  @UnionType(const [int, String])
  dynamic intStringUnion;
  @UnionType(const [List, Map])
  dynamic listMapUnion;

  void method(@UnionType(const [int, String]) intStringParam) {
    print('method');
  }
}

void function(@UnionType(const [int, String]) intStringParam) {
  print('function');
}
