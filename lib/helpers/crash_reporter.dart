import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shake_flutter/utils/dart_stack_trace_parser.dart';

typedef Future<void> CrashSender(Map<String, dynamic> crash);

/// Captures Dart errors and hands them to the native crash reporters.
class CrashReporter {
  final DartStackTraceParser _stackTraceParser = DartStackTraceParser();

  CrashSender? _send;
  FlutterExceptionHandler? _previousFlutterOnError;
  ErrorCallback? _previousPlatformOnError;

  /// Reports uncaught Dart errors as fatal crashes.
  ///
  /// Error handlers the app set up itself keep being called, the same way the
  /// native SDKs chain to the previously set uncaught exception handler.
  void attach(CrashSender send) {
    if (_send != null) return;

    _send = send;

    _previousFlutterOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      report(details.exception, details.stack, true, null);
      _previousFlutterOnError?.call(details);
    };

    _previousPlatformOnError = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
      report(error, stackTrace, true, null);

      /// Returning false here would make Flutter crash the app right after,
      /// turning on crash reporting must not introduce a new crash that
      /// would not have happened otherwise. Defaulting to true keeps the
      /// error reported without actually taking the process down; a host
      /// app handler that itself asks for that is still respected.
      return _previousPlatformOnError?.call(error, stackTrace) ?? true;
    };
  }

  /// Reports a single error.
  ///
  /// Reporting never throws: an error thrown while reporting an error would
  /// come back through the handlers that called this.
  void report(Object error, StackTrace? stackTrace, bool fatal, String? clusterId) {
    try {
      _send?.call(buildCrash(error, stackTrace, fatal, clusterId)).catchError((Object _) {});
    } catch (_) {}
  }

  Map<String, dynamic> buildCrash(Object error, StackTrace? stackTrace, bool fatal, String? clusterId) {
    final rawStackTrace = stackTrace?.toString();

    return {
      'type': error.runtimeType.toString(),
      'message': error.toString(),
      'frames': _stackTraceParser.parse(rawStackTrace),
      'rawStackTrace': rawStackTrace,
      'fatal': fatal,
      'clusterId': clusterId,
    };
  }
}
