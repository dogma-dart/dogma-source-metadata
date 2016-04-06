// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Retrieves the documentation comments from the [element].
///
/// If no documentation comments are found then the empty string will be
/// returned.
String elementComments(Element element) =>
    element.documentationComment ?? '';
