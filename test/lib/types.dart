// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

num n;
int i;
double d;
String s;
Null nu;
Symbol sy;
List l;
List<int> li;
Map m;
Map<String, int> msi;

class Nums<T extends num> {
  List<T> numbers;
}

Nums nums;
Nums<double> numsDouble;

void func(void f(int i),
          void o([int i]),
          void n({int i}),
          void g<T>(T t),
          void n(U e<U extends num>(U i))) {
  return f(2);
}
