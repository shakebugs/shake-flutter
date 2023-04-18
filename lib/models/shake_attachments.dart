import 'package:shake_flutter/models/shake_form_component.dart';

/// Represents Shake form Attachments.
class ShakeAttachments extends ShakeFormComponent {
  ShakeAttachments() : super('attachments');

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }

  /// Converts map to object.
  static ShakeAttachments fromMap(Map data) {
    return ShakeAttachments();
  }
}
