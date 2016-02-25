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

import 'package:analyzer/src/generated/element.dart';

import 'constant_object.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A function that takes a annotation [element] from the analyzer and returns
/// an instantiation of the metadata.
///
/// If the [element] is not a supported type of annotation then the function
/// will return `null`.
typedef dynamic AnalyzeAnnotation(ElementAnnotationImpl element);


typedef dynamic CreateAnnotationInstance(ClassMirror mirror,
                                         Symbol constructor,
                                         List positionalArguments,
                                         Map<Symbol, dynamic> namedArguments);

List createAnnotations(Element element,
                       List<AnalyzeAnnotation> annotationCreators) {
  var values = [];

  for (var metadata in element.metadata) {
    for (var creator in annotationCreators) {
      var value = creator(metadata);

      if (value != null) {
        values.add(value);
      }
    }
  }

  return values;
}

AnalyzeAnnotation analyze(String annotation,
                         {String library: '',
                          CreateAnnotationInstance createAnnotation: _createAnnotation}) {
  var clazz = classMirror(annotation, library);

  return (element) {
    var representation = element.element;

    // Check to see if the enclosing element is of the given type
    if (representation.enclosingElement.name != annotation) {
      return null;
    }

    var value;

    if (representation is ConstructorElement) {
      // Annotations are constant so get the result of the evaluation
      //
      // This ends up creating a generic object containing the resulting
      // fields of the instance.
      var evaluatedFields = element.evaluationResult.value.fields;

      // Get the invocation
      var positionalArguments = [];
      var namedArguments = <Symbol, dynamic>{};

      // Iterate over the parameters to get the mirrors call
      for (var parameter in representation.parameters) {
        var parameterName = parameter.name;
        var parameterField = evaluatedFields[parameterName];
        var parameterValue = dartValue(parameterField);

        if (parameter.parameterKind == 'NAMED') {
          namedArguments[new Symbol(parameterName)] = parameterValue;
        } else {
          positionalArguments.add(parameterValue);
        }
      }

      value = createAnnotation(
          clazz,
          new Symbol(''),
          positionalArguments,
          namedArguments
      );
    }

    return value;
  };
}

ClassMirror classMirror(String name, [String library = '']) =>
    library.isNotEmpty
        ? _classMirrorInLibrary(name, library)
        : _findClassMirror(name);

dynamic _createAnnotation(ClassMirror mirror,
                          Symbol constructor,
                          List positionalArguments,
                          Map<Symbol, dynamic> namedArguments) =>
    mirror.newInstance(
        constructor,
        positionalArguments,
        namedArguments
    ).reflectee;

ClassMirror _classMirrorInLibrary(String name, String libraryName) {
  var library = currentMirrorSystem().findLibrary(new Symbol(libraryName));

  if (library == null) {
    throw new ArgumentError.value(libraryName, 'Was not found within the mirrors system');
  }

  var mirror = library.declarations[new Symbol(name)];

  if (mirror == null) {
    throw new ArgumentError.value(name, 'Was not found within $libraryName');
  } else if (mirror is! ClassMirror) {
    throw new ArgumentError.value(name, 'Does not refer to a class');
  }

  return mirror;
}

ClassMirror _findClassMirror(String name) {
  var symbol = new Symbol(name);
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

