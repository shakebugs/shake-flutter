import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Files {
  static Future<String> getApplicationDirectory() async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  static Future<File> createDummyFile(String name) async {
    File file = File(await getApplicationDirectory() + "/" + name);
    file.writeAsString("Lorem ipsum dolor sit amet");

    return file;
  }
}
