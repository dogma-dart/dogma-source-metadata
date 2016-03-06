// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:logging/logging.dart';

import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void main() {
  // Start logging
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  var context = analysisContext();
  var library = libraryMetadata(
      Uri.parse('package:dogma_source_analyzer/metadata.dart'),
      context
  );

  var classQuery = libraryMetadataQueryAll/*<ClassMetadata>*/(
      library,
      (value) => value is ClassMetadata,
      includeClasses: true,
      includeExports: true
  );

  var classCount = classQuery.length;
  print('Contains $classCount classes');

  // Get the number of constructors
  var constructorQuery = classQuery.expand/*<ConstructorMetadata>*/(
      (metadata) => classMetadataQueryAll/*<ConstructorMetadata>*/(
          metadata,
          (value) => value is ConstructorMetadata,
          includeConstructors: true
      )
  );

  var constructorCount = constructorQuery.length;
  var inverseConstructorCount = 100 / constructorCount;

  // Get the number of default constructors
  var defaultConstructorQuery = classQuery.map/*<ConstructorMetadata>*/(
      (metadata) =>
          (metadata as ClassMetadata).constructors.where(defaultConstructorMatch)
  );

  var defaultConstructorCount = defaultConstructorQuery.length;
  var defaultConstructorPercent = defaultConstructorCount * inverseConstructorCount;

  // Get the number of factory constructors
  var factoryConstructorQuery = classQuery.expand/*<ConstructorMetadata>*/(
      (metadata) =>
          (metadata as ClassMetadata).constructors.where(factoryConstructorMatch)
  );

  var factoryConstructorCount = factoryConstructorQuery.length;
  var factoryConstructorPercent = factoryConstructorCount * inverseConstructorCount;

  // Get the number of named constructors
  var namedConstructorQuery = classQuery.expand/*<ConstructorMetadata>*/(
      (metadata) =>
          (metadata as ClassMetadata).constructors.where(namedConstructorMatch)
  );

  var namedConstructorCount = namedConstructorQuery.length;
  var namedConstructorPercent = namedConstructorCount * inverseConstructorCount;

  print('Contains $constructorCount constructors');
  print('Contains $defaultConstructorCount default constructors ($defaultConstructorPercent%)');
  print('Contains $factoryConstructorCount factory constructors ($factoryConstructorPercent%)');
  print('Contains $namedConstructorCount named constructors ($namedConstructorPercent%)');
}
