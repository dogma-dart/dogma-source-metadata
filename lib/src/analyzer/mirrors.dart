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

import 'package:logging/logging.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.mirrors');

/// Creates an instance of an annotation using the class [mirror] and invoking
/// the [constructor] with the [positionalArguments] and [namedArguments].
typedef dynamic CreateAnnotationInstance(ClassMirror mirror,
                                         Symbol constructor,
                                         List positionalArguments,
                                         Map<Symbol, dynamic> namedArguments);

/// Gets the class mirror for the class with the [name].
///
/// If a [library] name is given then this will narrow down the search for the
/// class mirror. It is not a requirement unless the class name is not unique
/// within the loaded libraries.
ClassMirror classMirror(String name, [String library = '']) =>
    library.isNotEmpty
        ? _classMirrorInLibrary(name, library)
        : _findClassMirror(name);

/// Gets the symbol for a private constructor on the [mirror] which matches the
/// symbol [value].
///
/// When accessing a private value with mirrors the symbol cannot be created
/// directly. This is because there is additional data appended to it. However
/// it can still be retrieved using the symbol [value] as the toString() value
/// will be the same.
Symbol privateConstructor(ClassMirror mirror, Symbol value) {
  // Convert the value to a string
  final valueString = value.toString();

  for (var declaration in mirror.declarations.values) {
    if ((declaration is MethodMirror) && (declaration.isConstructor)) {
      final constructorSymbol = declaration.constructorName;

      // If the toString values match then the value is equivalent.
      if (constructorSymbol.toString() == valueString) {
        return constructorSymbol;
      }
    }
  }

  assert(false);
  return null;
}

/// Creates an annotation using its [mirror] and its [constructor].
///
/// The constructor is called with the [positionalArguments] and
/// [namedArguments]. The result is then returned.
dynamic createAnnotation(ClassMirror mirror,
                         Symbol constructor,
                         List positionalArguments,
                         Map<Symbol, dynamic> namedArguments) =>
    mirror.newInstance(
        constructor,
        positionalArguments,
        namedArguments
    ).reflectee;

/// Finds the class mirror using its [name] within the [library].
ClassMirror _classMirrorInLibrary(String name, String library) {
  final libraryMirror = currentMirrorSystem().findLibrary(new Symbol(library));

  if (libraryMirror == null) {
    throw new ArgumentError.value(library, 'Was not found within the mirrors system');
  }

  final mirror = libraryMirror.declarations[new Symbol(name)];

  if (mirror == null) {
    throw new ArgumentError.value(name, 'Was not found within $library');
  } else if (mirror is! ClassMirror) {
    throw new ArgumentError.value(name, 'Does not refer to a class');
  }

  return mirror;
}

/// Searches the currently loaded libraries for a class with the given [name].
ClassMirror _findClassMirror(String name) {
  final symbol = new Symbol(name);
  var mirror;

  // Iterate over all libraries within the mirrors system
  for (var library in currentMirrorSystem().libraries.values) {
    mirror = library.declarations[symbol];

    if (mirror != null) {
      break;
    }
  }

  if (mirror == null) {
    throw new ArgumentError.value(name, 'Was not found within the mirrors system');
  } else if (mirror is! ClassMirror) {
    throw new ArgumentError.value(name, 'Does not refer to a class');
  }

  return mirror;
}
