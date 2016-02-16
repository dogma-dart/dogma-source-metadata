// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

class ClassFields {
  static String classField = 'classStaticField';
  static final String classFinalField = 'classFinalField';
  static const String classConstField = 'classConstField';
  static String _classPrivateField = '_classPrivateField';

  static String get classPrivateFieldGetter => _classPrivateField;

  static String get classPrivateFieldGetterSetter => _classPrivateField;
  static set classPrivateFieldGetterSetter(String value) {
    _classPrivateField = value;
  }

  String instanceField = 'instanceField';
  final String instanceFinalField = 'instanceFinalField';
  String _instancePrivateField = '_instancePrivateField';

  String get instancePrivateFieldGetter => _instancePrivateField;

  String get instancePrivateFieldGetterSetter => _instancePrivateField;
  set instancePrivateFieldGetterSetter(String value) {
    _instancePrivateField = value;
  }
}
