// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:logging/logging.dart';

import 'package:dogma_source_metadata/analyzer.dart';
import 'package:dogma_source_metadata/metadata.dart';
import 'package:dogma_source_metadata/matcher.dart';
import 'package:dogma_source_metadata/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Entry point for the example.
void main() {
  // Start logging
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  final context = analysisContext();
  final library = libraryMetadata(
      Uri.parse('package:dogma_source_metadata/metadata.dart'),
      context
  );

  final classQuery = libraryMetadataQueryAll/*<ClassMetadata>*/(
      library,
      (value) => value is ClassMetadata,
      includeClasses: true,
      includeExports: true
  );

  final classCount = classQuery.length;
  print('Contains $classCount classes');

  // Get the number of constructors
  final constructorQuery = classQuery.expand/*<ConstructorMetadata>*/(
      (metadata) => classMetadataQueryAll/*<ConstructorMetadata>*/(
          metadata,
          (value) => value is ConstructorMetadata,
          includeConstructors: true
      )
  );

  final constructorCount = constructorQuery.length;
  final inverseConstructorCount = 100 / constructorCount;

  // Get the number of default constructors
  final defaultConstructorQuery =
      constructorQuery.where(defaultConstructorMatch);

  final defaultConstructorCount = defaultConstructorQuery.length;
  final defaultConstructorPercent =
      defaultConstructorCount * inverseConstructorCount;

  // Get the number of factory constructors
  final factoryConstructorQuery =
      constructorQuery.where(factoryConstructorMatch);

  final factoryConstructorCount = factoryConstructorQuery.length;
  final factoryConstructorPercent =
      factoryConstructorCount * inverseConstructorCount;

  // Get the number of named constructors
  final namedConstructorQuery = constructorQuery.where(namedConstructorMatch);

  final namedConstructorCount = namedConstructorQuery.length;
  final namedConstructorPercent =
      namedConstructorCount * inverseConstructorCount;

  print('Contains $constructorCount constructors');
  print('Contains $defaultConstructorCount default constructors ($defaultConstructorPercent%)');
  print('Contains $factoryConstructorCount factory constructors ($factoryConstructorPercent%)');
  print('Contains $namedConstructorCount named constructors ($namedConstructorPercent%)');
}
