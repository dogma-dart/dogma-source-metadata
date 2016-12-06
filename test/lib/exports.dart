// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

export 'functions.dart' show empty;
export 'annotation.dart' hide Annotated, AnnotationTypes;

export 'library_interface.dart'
  if (dart.library.io) 'library_io.dart'
  if (dart.library.html) 'library_html.dart';
