import 'package:shake_flutter/models/shake_form_component.dart';

/// Represents Shake form Text input.
class ShakeTextInput extends ShakeFormComponent {
  String label;
  String? labelRes;
  String initialValue;
  bool required;

  ShakeTextInput(this.label,
      {this.labelRes, this.initialValue = "", this.required = false})
      : super('text_input');

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'label': label,
      'labelRes': labelRes,
      'initialValue': initialValue,
      'required': required
    };
  }

  /// Converts map to object.
  static ShakeTextInput fromMap(Map data) {
    String label = data['label'] ?? '';
    String? labelRes = data['labelRes'];
    String initialValue = data['initialValue'] ?? '';
    bool required = data['required'] ?? false;

    return ShakeTextInput(label,
        labelRes: labelRes, initialValue: initialValue, required: required);
  }
}
