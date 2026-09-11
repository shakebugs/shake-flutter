import 'package:flutter_test/flutter_test.dart';
import 'package:shake_flutter/utils/dart_stack_trace_parser.dart';

void main() {
  final parser = DartStackTraceParser();

  test('parses file, line and method of a frame', () {
    final frames = parser.parse('#0      MyWidget.build (package:myapp/main.dart:25:11)');

    expect(frames.length, 1);
    expect(frames.first['file'], 'package:myapp/main.dart');
    expect(frames.first['line'], '25');
    expect(frames.first['method'], 'MyWidget.build');
    expect(frames.first['is_application'], true);
  });

  test('parses a frame without a column', () {
    final frames = parser.parse('#0      MyWidget.build (package:myapp/main.dart:25)');

    expect(frames.first['file'], 'package:myapp/main.dart');
    expect(frames.first['line'], '25');
  });

  test('parses a frame without a source position', () {
    final frames = parser.parse('#0      MyWidget.build (package:myapp/main.dart)');

    expect(frames.first['file'], 'package:myapp/main.dart');
    expect(frames.first['line'], '');
  });

  test('parses a file url frame', () {
    final frames = parser.parse('#0      main (file:///Users/me/app/lib/main.dart:10:5)');

    expect(frames.first['file'], 'file:///Users/me/app/lib/main.dart');
    expect(frames.first['line'], '10');
  });

  test('parses closures', () {
    final frames = parser.parse('#3      main.<anonymous closure> (package:myapp/main.dart:12:3)');

    expect(frames.first['method'], 'main.<anonymous closure>');
    expect(frames.first['line'], '12');
  });

  test('marks sdk and framework frames as non application', () {
    final frames = parser.parse('''
#0      MyWidget.build (package:myapp/main.dart:25:11)
#1      StatelessElement.build (package:flutter/src/widgets/framework.dart:4629:28)
#2      _rootRunUnary (dart:async/zone.dart:1399:47)
#3      Shake.handleError (package:shake_flutter/shake_flutter.dart:120:5)
''');

    expect(frames.map((frame) => frame['is_application']), [true, false, false, false]);
  });

  test('skips asynchronous suspension markers', () {
    final frames = parser.parse('''
#0      loadUser (package:myapp/user.dart:8:3)
<asynchronous suspension>
#1      main (package:myapp/main.dart:4:3)
''');

    expect(frames.length, 2);
    expect(frames.map((frame) => frame['method']), ['loadUser', 'main']);
  });

  test('indexes frames in the order they appear', () {
    final frames = parser.parse('''
#0      first (package:myapp/a.dart:1:1)
#1      second (package:myapp/b.dart:2:2)
''');

    expect(frames.map((frame) => frame['method']), ['first', 'second']);
  });

  test('parses no frames of an obfuscated release trace', () {
    final frames = parser.parse('''
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
pid: 1234, tid: 5678, name 1.ui
build_id: 'a1b2c3d4e5f6'
isolate_dso_base: 722e4f0000, vm_dso_base: 722e4f0000
    #00 abs 000000722e50d98b virt 0000000000bd598b _kDartIsolateSnapshotInstructions+0x1d98b
    #01 abs 000000722e50d1f7 virt 0000000000bd51f7 _kDartIsolateSnapshotInstructions+0x1d1f7
''');

    expect(frames, isEmpty);
  });

  test('parses no frames of an empty trace', () {
    expect(parser.parse(null), isEmpty);
    expect(parser.parse(''), isEmpty);
  });
}
