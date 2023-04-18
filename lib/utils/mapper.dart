import 'package:shake_flutter/enums/shake_screen.dart';
import 'package:shake_flutter/models/shake_file.dart';

class Mapper {
  /// Converts list of [ShakeFile] to list of maps.
  List<Map<String, dynamic>> shakeFilesToMap(List<ShakeFile> shakeFiles) {
    return shakeFiles.map((shakeFile) => shakeFile.toMap()).toList();
  }

  /// Converts string to [ShakeScreen].
  ShakeScreen mapToShakeScreen(String shakeScreenStr) {
    if (shakeScreenStr == "newTicket") return ShakeScreen.newTicket;
    if (shakeScreenStr == "home") return ShakeScreen.home;

    return ShakeScreen.newTicket;
  }
}
