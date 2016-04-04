
import 'metadata.dart';
import 'library_metadata.dart';
import 'enclosing_metadata.dart';

class UriReferencedMetadata extends Metadata with EnclosingMetadata {
  /// The prefix to use for the reference.
  final String prefix;
  /// The names within the library that are shown.
  final List<String> shownNames;
  /// The names within the library that are hidden.
  final List<String> hiddenNames;
  /// The metadata for the library being referenced.
  LibraryMetadata library;

  UriReferencedMetadata({String prefix,
                         List<String> shownNames,
                         List<String> hiddenNames})
      : prefix = prefix ?? ''
      , shownNames = shownNames ?? <String>[]
      , hiddenNames = hiddenNames ?? <String>[]
      , super('');
}
