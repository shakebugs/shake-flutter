import 'package:shake_flutter/enums/shake_screen.dart';

class Mapper {
  /// Converts string to [ShakeScreen].
  ShakeScreen mapToShakeScreen(String shakeScreenStr) {
    if (shakeScreenStr == "newTicket") return ShakeScreen.newTicket;
    if (shakeScreenStr == "home") return ShakeScreen.home;

    return ShakeScreen.newTicket;
  }
}
