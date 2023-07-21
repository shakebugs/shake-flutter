import 'package:shake_flutter/models/shake_form_component.dart';

/// Represents Shake form Email input.
class ShakeEmail extends ShakeFormComponent {
  String key;
  String? label;
  String initialValue;
  bool required;

  String? labelRes;

  ShakeEmail(
    this.key,
    this.label, {
    this.initialValue = "",
    this.required = false,
    this.labelRes,
  }) : super('email');

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'key': key,
      'label': label,
      'initialValue': initialValue,
      'required': required,
      'labelRes': labelRes,
    };
  }

  /// Converts map to object.
  static ShakeEmail fromMap(Map data) {
    String key = data['key'] ?? '';
    String? label = data['label'];
    String initialValue = data['initialValue'] ?? '';
    bool required = data['required'] ?? false;
    String? labelRes = data['labelRes'];

    return ShakeEmail(
      key,
      label,
      initialValue: initialValue,
      required: required,
      labelRes: labelRes,
    );
  }
}
