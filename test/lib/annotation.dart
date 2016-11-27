// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

@Annotation('library')
library dogma_source_metadata.test.lib.annotation;

class Annotation {
  final String value;
  final dynamic extend;

  const Annotation(this.value,
                  {this.extend});
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

@Annotation('enum')
enum Enum {
  a, b, c
}

class AnnotationTypes {
  @Annotation('int', extend: 0)
  int intValue;
  @Annotation('bool', extend: true)
  bool boolValue;
  @Annotation('num', extend: 2.0)
  num numValue;
  @Annotation('type', extend: Type)
  Type typeValue;
  @Annotation('symbol', extend: #symbol)
  Symbol symbolValue;
  @Annotation('null', extend: null)
  Null nullValue;
  @Annotation('list', extend: const [0, 1, 2, 3])
  List listValue;
  @Annotation('map', extend: const {'a': 0, 'b': 1})
  Map mapValue;
}
