// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

void empty() {
  print('I am empty!!!!!!');
}

int _private([int p0 = 0, int p1 = 1, int p2 = 2, int p3 = 3]) =>
    p0 + p1 + p2 + p3;

int required(int foo, int bar) => foo + bar;
int named(int foo, {int bar: 2}) => foo + bar;
int optional(int foo, [int bar = 2]) => foo + bar;

dynamic/*=T*/ generic/*<T>*/(dynamic/*=T*/ foo, dynamic/*=T*/ bar) =>
    (foo != bar) ? foo : bar;
