
import 'package:test/test.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart';
import 'package:dogma_source_analyzer/query.dart';

import '../../lib/annotation.dart';

void _expectHasAnnotation(AnnotatedMetadata metadata, String value) {
  expect(metadata.annotations, hasLength(1));

  var annotation = metadata.annotations[0];
  expect(annotation is Annotation, isTrue);
  expect(annotation.value, value);
}

void _expectParamHasAnnotation(FunctionMetadata metadata, String value) {
  expect(metadata.parameters, hasLength(1));

  _expectHasAnnotation(metadata.parameters[0], value);
}

/// Entry point for tests.
void main() {
  var context = analysisContext();

  test('annotation', () {
    var create = analyzeAnnotation('Annotation');
    var library = libraryMetadata(
        join('test/lib/annotation.dart'),
        context,
        annotationCreators: [create]
    );

    expect(library, isNotNull);
    expect(library.classes, hasLength(4));
    expect(library.fields, hasLength(1));
    expect(library.functions, hasLength(1));

    // Check library annotations
    _expectHasAnnotation(library, 'library');
    _expectHasAnnotation(library.fields[0], 'library_field');
    _expectHasAnnotation(library.functions[0], 'function');
    _expectParamHasAnnotation(library.functions[0], 'function_parameter');

    var clazz = libraryMetadataQuery/*<ClassMetadata>*/(
        library,
        nameMatch('Annotated'),
        includeClasses: true
    ) as ClassMetadata;

    expect(clazz, isNotNull);
    expect(clazz.constructors, hasLength(1));
    expect(clazz.fields, hasLength(2));
    expect(clazz.methods, hasLength(1));

    // Check class annotations
    _expectHasAnnotation(clazz, 'class');
    _expectHasAnnotation(clazz.constructors[0], 'constructor');
    _expectHasAnnotation(clazz.methods[0], 'method');
    _expectParamHasAnnotation(clazz.methods[0], 'parameter');

    // Check field annotations
    //
    // There's on property and one field
    for (var field in clazz.fields) {
      var value = field.isProperty ? 'property' : 'field';

      _expectHasAnnotation(field, value);
    }
  });
}
