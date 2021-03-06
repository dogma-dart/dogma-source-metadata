// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

import 'dart:html' as html;
import 'functions.dart' show empty;
import 'annotation.dart' hide Annotated, AnnotationTypes;
import 'deprecated.dart' deferred as deprecated;

import 'library_interface.dart'
  if (dart.library.io) 'library_io.dart'
  if (dart.library.html) 'library_html.dart';
