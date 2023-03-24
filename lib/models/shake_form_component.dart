import 'package:shake_flutter/models/shake_attachments.dart';
import 'package:shake_flutter/models/shake_email.dart';
import 'package:shake_flutter/models/shake_inspect_button.dart';
import 'package:shake_flutter/models/shake_picker.dart';
import 'package:shake_flutter/models/shake_text_input.dart';
import 'package:shake_flutter/models/shake_title.dart';

/// Represents Shake form component.
abstract class ShakeFormComponent {
  String type;

  ShakeFormComponent(this.type);

  /// Converts object to map.
  Map<String, dynamic> toMap();

  /// Converts map to object.
  static ShakeFormComponent? fromMap(Map data) {
    var type = data['type'];
    switch (type) {
      case 'title':
        return ShakeTitle.fromMap(data);
      case 'text_input':
        return ShakeTextInput.fromMap(data);
      case 'email':
        return ShakeEmail.fromMap(data);
      case 'picker':
        return ShakePicker.fromMap(data);
      case 'inspect':
        return ShakeInspectButton.fromMap(data);
      case 'attachments':
        return ShakeAttachments.fromMap(data);
    }
    return null;
  }
}
