// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// The metadata_builder library contains metadata builders which can be used to
/// generate metadata using a fluent interface. It is the preferred way to
/// create instances of Metadata rather than instantiating Metadata instances
/// directly.
///
/// # Usage
///
///
///
///     var lib = library()
///         ..classes = <ClassMetadataBuilder>[
///             clazz('Foo')
///                 ..fields = <FieldMetadataBuilder>[
///                     field('bar')
///                         ..type = intType
///                 ]
///         ]
///         ..functions = <FunctionMetadataBuilder>[
///             function('foobar')
///                 ..returnType = intType
///                 ..parameters = <ParameterMetadataBuilder>[
///
///                 ]
///
///
///
/// # Validation
///
/// MetadataBuilders contain validation for the metadata being built. The
/// validation is meant to catch errors that would result in constructs that
/// are not semantically correct Dart code.
///
/// As an example a field can be static, but only within the context of a class.
/// Fields can also be present within a library so the builder for a library
/// will validate that no fields are marked as static.
///
///     var lib = library()
///         ..fields = <FieldMetadataBuilder>[
///             field('incorrect')
///                 ..isStatic = true
///         ].build();
///
/// When metadata cannot be built correctly from the provided values an
/// InvalidMetadataError is thrown.
library dogma_source_metadata.metadata_builder;

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'src/metadata_builder/abstract_metadata_builder.dart';
export 'src/metadata_builder/class_metadata_builder.dart';
export 'src/metadata_builder/constant_metadata_builder.dart';
export 'src/metadata_builder/constructor_metadata_builder.dart';
export 'src/metadata_builder/enum_metadata_builder.dart';
export 'src/metadata_builder/field_metadata_builder.dart';
export 'src/metadata_builder/function_metadata_builder.dart';
export 'src/metadata_builder/invalid_metadata_error.dart';
export 'src/metadata_builder/library_metadata_builder.dart';
export 'src/metadata_builder/metadata_builder.dart';
export 'src/metadata_builder/method_metadata_builder.dart';
export 'src/metadata_builder/parameter_metadata_builder.dart';
export 'src/metadata_builder/static_metadata_builder.dart';
export 'src/metadata_builder/typed_metadata_builder.dart';
export 'src/metadata_builder/typedef_metadata_builder.dart';
export 'src/metadata_builder/uri_referenced_metadata_builder.dart';
