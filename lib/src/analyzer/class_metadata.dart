// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/dart/element/element.dart';
import 'package:logging/logging.dart';

import '../../metadata.dart';
import 'annotation.dart';
import 'comments.dart';
import 'constructor_metadata.dart';
import 'field_metadata.dart';
import 'method_metadata.dart';
import 'type_metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The logger for the library.
final Logger _logger =
    new Logger('dogma_source_analyzer.src.analyzer.class_metadata');

/// Creates class metadata from the given [element].
ClassMetadata classMetadata(ClassElement element,
                            List<AnalyzeAnnotation> annotationCreators) {
  final name = element.name;
  _logger.info('Creating metadata for class $name');

  // Get the supertype
  final supertypeElement = element.supertype;
  final supertypeName = supertypeElement.name;

  _logger.fine('Found that $name extends $supertypeName');
  final supertype = typeMetadata(supertypeElement);

  // Get the classes that are mixed in
  final mixins = <TypeMetadata>[];

  for (var mixin in element.mixins) {
    final mixinType = typeMetadata(mixin);

    _logger.fine('Found that $name mixes in ${mixinType.name}');

    mixins.add(mixinType);
  }

  // Get the interfaces the class implements
  final interfaces = <TypeMetadata>[];

  for (var interface in element.interfaces) {
    final interfaceType = typeMetadata(interface);

    _logger.fine('Found that $name implements ${interfaceType.name}');

    interfaces.add(interfaceType);
  }

  // Get the fields
  final fields = <FieldMetadata>[];

  for (var field in element.fields) {
    final fieldName = field.name;
    _logger.fine('Found field $fieldName on $name');

    fields.add(fieldMetadata(field, annotationCreators).build());
  }

  // Get the methods
  final methods = <MethodMetadata>[];

  for (var method in element.methods) {
    final methodName = method.name;
    _logger.fine('Found method $methodName on $name');

    methods.add(methodMetadata(method, annotationCreators));
  }

  // Get the constructors
  final constructors = <ConstructorMetadata>[];
  final constructorReturnType = type(name);

  for (var constructor in element.constructors) {
    constructors.add(constructorMetadata(
        constructor,
        constructorReturnType,
        annotationCreators
    ));
  }

  // Get the annotations
  final annotations = createAnnotations(element, annotationCreators);

  if (element.isEnum) {
    return new EnumMetadata(
        name,
        fields,
        annotations: annotations,
        comments: elementComments(element)
    );
  } else {
    return new ClassMetadata(
        name,
        supertype: supertype,
        interfaces: interfaces,
        isAbstract: element.isAbstract,
        mixins: mixins,
        fields: fields,
        methods: methods,
        constructors: constructors,
        annotations: annotations,
        comments: elementComments(element)
    );
  }
}
