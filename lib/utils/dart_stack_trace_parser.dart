/// Parses a Dart stack trace into frames the native SDKs understand.
///
/// Only this class knows the Dart stack trace format. A crash of another
/// runtime reaches the same native crash reporting through its own parser.
class DartStackTraceParser {
  static final RegExp _frame = RegExp(r'^#\d+\s+(.+?)\s+\((.+)\)$');

  static const List<String> _libraryPrefixes = [
    'dart:',
    'package:flutter/',
    'package:flutter_test/',
    'package:shake_flutter/',
  ];

  /// Parses [stackTrace] into frames.
  ///
  /// Returns no frames for a trace that holds no source positions, an
  /// obfuscated release trace for example, which stays readable only as text.
  List<Map<String, dynamic>> parse(String? stackTrace) {
    if (stackTrace == null || stackTrace.isEmpty) return [];

    final frames = <Map<String, dynamic>>[];

    for (final line in stackTrace.split('\n')) {
      final frame = _parseFrame(line.trim());
      if (frame != null) frames.add(frame);
    }

    return frames;
  }

  Map<String, dynamic>? _parseFrame(String line) {
    final match = _frame.firstMatch(line);
    if (match == null) return null;

    final method = match.group(1)!;
    final location = match.group(2)!;
    final segments = location.split(':');

    /// A location ends with ":line:column" or ":line". Everything before that
    /// is the file, which holds a colon of its own in "package:app/main.dart".
    var file = location;
    var lineNumber = '';

    if (segments.length >= 3 && _isNumber(segments[segments.length - 1]) && _isNumber(segments[segments.length - 2])) {
      lineNumber = segments[segments.length - 2];
      file = segments.sublist(0, segments.length - 2).join(':');
    } else if (segments.length >= 2 && _isNumber(segments.last)) {
      lineNumber = segments.last;
      file = segments.sublist(0, segments.length - 1).join(':');
    }

    return {
      'file': file,
      'line': lineNumber,
      'method': method,
      'is_application': _isApplication(file),
    };
  }

  bool _isApplication(String file) {
    return !_libraryPrefixes.any((prefix) => file.startsWith(prefix));
  }

  bool _isNumber(String value) {
    return value.isNotEmpty && int.tryParse(value) != null;
  }
}
