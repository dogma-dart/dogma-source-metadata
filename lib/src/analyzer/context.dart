// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/package_map_resolver.dart';
import 'package:analyzer/source/pub_package_map_provider.dart';
import 'package:analyzer/src/dart/sdk/sdk.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/java_io.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:cli_util/cli_util.dart';

import '../../path.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Creates an analysis context for a project.
///
/// The [projectPath] refers to the root of the repository. The [sdkPath]
/// points to the installed location of the Dart SDK.
AnalysisContext analysisContext({Uri projectPath, Uri sdkPath}) {
  projectPath ??= currentPathUri;
  sdkPath ??= getSdkDir().uri;

  final sdkFilePath = sdkPath.toFilePath();

  // Setup the core dart libraries
  JavaSystemIO.setProperty('com.google.dart.sdk', sdkFilePath);
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final sdk = new FolderBasedDartSdk(
      resourceProvider,
      resourceProvider.getFolder(sdkFilePath)
  );

  // Using the .packages file
  final pubPackageMapProvider = new PubPackageMapProvider(
      PhysicalResourceProvider.INSTANCE,
      sdk
  );

  final packageMapInfo = pubPackageMapProvider
      .computePackageMap(PhysicalResourceProvider.INSTANCE.getResource('.'));

  // Create the resolvers
  final resolvers = <UriResolver>[
      new DartUriResolver(sdk),
      new ResourceUriResolver(PhysicalResourceProvider.INSTANCE),
      new PackageMapUriResolver(
          PhysicalResourceProvider.INSTANCE,
          packageMapInfo.packageMap
      )
  ];

  // Set the analysis options
  final options = new AnalysisOptionsImpl()
      ..preserveComments = true
      ..strongMode = true
      ..enableGenericMethods = true
      ..analyzeFunctionBodies = false;

  // Return the context
  return AnalysisEngine.instance.createAnalysisContext()
      ..analysisOptions = options
      ..sourceFactory = new SourceFactory(resolvers);
}
