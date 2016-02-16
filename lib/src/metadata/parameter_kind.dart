// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The type of parameter.
enum ParameterKind {
  /// The parameter is required.
  required,
  /// The parameter is optional.
  ///
  /// It uses the \[\] syntax when declared.
  optional,
  /// The parameter is named.
  ///
  /// It uses the {} syntax when declared.
  named
}
