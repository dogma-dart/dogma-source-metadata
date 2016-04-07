// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

import 'package:meta/meta.dart';

class Base {
  @protected
  int onlySubClasses() => 1;
}

class Subclass extends Base {
  int doSomething() => onlySubClasses();
}
