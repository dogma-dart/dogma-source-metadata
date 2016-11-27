// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Provides functionality to analyze the source code of a library.
///
/// In order to begin analyzing source code an analysis context must be
/// created by the application. The function [analysisContext] handles the
/// instantiation of the context.
///
///     import 'package:dogma_source_analysis/analyzer.dart';
///
///     var context = analysisContext();
///
/// Once the analysis context is created it can be used to get the metadata
/// from a library through the [libraryMetadata] function.
///
///     var library = libraryMetadata(Uri.parse('package:foo/bar.dart'), context);
///
/// A call to [libraryMetadata] will result in metadata being created for the
/// given library and any other library's within its scope. If the uri points
/// to a package then this will instantiate any libraries within the package's
/// source code. If the uri points to a file then only file uri's will be
/// instantiated. This is done to minimize the amount of source code that needs
/// to be analyzed.
library dogma_source_metadata.analyzer;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'src/analyzer/context.dart';
import 'src/analyzer/library_metadata.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/analyzer/annotation.dart';
export 'src/analyzer/constant_object.dart';
export 'src/analyzer/context.dart';
export 'src/analyzer/library_metadata.dart';
export 'src/analyzer/mirrors.dart';
