import 'package:path/path.dart';

class ShakeFile {
  String path;
  String name;

  ShakeFile.create(String path, [String name]) {
    this.path = path;
    if (name != null) {
      this.name = name + extension(path);
    } else {
      this.name = basename(path);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "path": path,
      "name": name,
    };
  }
}
