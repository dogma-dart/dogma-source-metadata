// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:mirrors';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_union_type/union_type.dart';
import 'package:logging/logging.dart';

import 'annotation.dart';
import 'mirrors.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.union_type_annotation');

/// Determines if the annotation corresponds to a [UnionType] annotation.
final AnalyzeAnnotation analyzeTypeUnionAnnotation =
    analyzeAnnotation(
        'UnionType',
        library: 'dogma_union_type.union_type',
        createAnnotation: _createTypeUnionAnnotation
    );

/// The symbol for the private constructor.
Symbol _privateConstructor;

/// Creates an instance of [UnionType] from the given [mirror].
dynamic _createTypeUnionAnnotation(ClassMirror mirror,
                                   Symbol _,
                                   List positionalArguments,
                                   Map<Symbol, dynamic> namedArguments) {
  _privateConstructor ??= privateConstructor(mirror, new Symbol('_'));

  return mirror.newInstance(
      _privateConstructor,
      positionalArguments,
      namedArguments
  ).reflectee;
}
