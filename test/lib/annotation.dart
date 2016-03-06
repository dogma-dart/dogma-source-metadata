// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

@Annotation('library')
library dogma_source_analyzer.test.lib.annotation;

class Annotation {
  final String value;

  const Annotation(this.value);
}

@Annotation('class')
class Annotated {
  @Annotation('constructor')
  Annotated();

  @Annotation('field')
  int field;

  @Annotation('property')
  int get property => field * 2;

  @Annotation('method')
  String method(@Annotation('parameter') String param) => '$field$param';
}

@Annotation('library_field')
final String field = 'library_field';

@Annotation('function')
void function(@Annotation('function_parameter') String param) {
  print('I be annotated $param');
}
