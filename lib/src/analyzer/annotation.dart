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
import 'package:analyzer/src/generated/utilities_dart.dart';
import 'package:logging/logging.dart';

import 'constant_object.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.annotation');

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

/// Maps the name of the [parameter] to the computed value of the instance
/// based on the [constructor].
///
/// When instantiating the value of a constant object the analyzer returns the
/// structure of the final object.
///
///     class Annotation {
///       final int field;
///
///       Annotation(this.field);
///     }
///
/// In this case the `field` passed into the constructor directly corresponds
/// to the value of object the analyzer computes. This is true for any values
/// created using the `this.*` syntax.
///
/// However the API may not have this 1-1 relationship.
///
///      class Annotation {
///        final int field;
///        final int otherField;
///
///         Annotation(int value, this.otherField)
///            : field = value;
///      }
///
/// In this case to construct an instance of the annotation a mapping needs to
/// be provided. An example implementation in this case would be.
///
///     String mapAnnotationParameter(String constructor, String parameter) =>
///         parameter == 'value' ? 'field' : parameter;
///
/// A mapping function is required for any annotations where the names of the
/// parameters do not correspond to the names of the fields within the
/// constructed object.
typedef String ParameterNameMapper(String constructorName, String parameter);

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
                          ParameterNameMapper parameterNameMapper: _passThroughParameters,
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
      var constructorName = representation.name;
      _logger.fine('Annotation is being constructed through "$constructorName"');

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
        var mappedParameterName = parameterNameMapper(constructorName, parameterName);
        var parameterField = evaluatedFields[mappedParameterName];
        var parameterValue = dartValue(parameterField);

        _logger.fine('Found $parameterName of value $parameterValue');
        _logger.finer('Parameter is mapped to $mappedParameterName');

        if (parameter.parameterKind == ParameterKind.NAMED) {
          _logger.finer('Parameter is named');
          namedArguments[new Symbol(parameterName)] = parameterValue;
        } else {
          _logger.finer('Parameter is positional');
          positionalArguments.add(parameterValue);
        }
      }

      value = createAnnotation(
          clazz,
          new Symbol(representation.name),
          positionalArguments,
          namedArguments
      );
    } else if (representation is PropertyAccessorElement) {
      _logger.finer('Annotation is a field');
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

/// Passes through the [parameter] name.
///
/// Used when a [ParameterNameMapper] is not provided.
String _passThroughParameters(String _, String parameter) => parameter;
