import 'package:shake_flutter/models/shake_form_component.dart';

/// Represents Shake form Inspect button.
class ShakeInspectButton extends ShakeFormComponent {
  ShakeInspectButton() : super('inspect');

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }

  /// Converts map to object.
  static ShakeInspectButton fromMap(Map data) {
    return ShakeInspectButton();
  }
}
