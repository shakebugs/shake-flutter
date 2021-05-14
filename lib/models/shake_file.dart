import 'package:path/path.dart';

/// Bug report file.
///
/// Use [ShakeFile.create] to create new file.
class ShakeFile {
  String? path;
  String? name;

  /// Creates new file.
  ShakeFile.create(String path, [String? name]) {
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
