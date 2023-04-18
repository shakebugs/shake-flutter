import 'package:shake_flutter/models/shake_form_component.dart';

/// Represents Shake form.
class ShakeForm {
  List<ShakeFormComponent> components;

  ShakeForm(this.components);

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> componentsMaps =
        components.map((c) => c.toMap()).toList();

    return {
      'components': componentsMaps,
    };
  }

  /// Converts map to object.
  static ShakeForm fromMap(Map data) {
    List<dynamic> componentsMaps = data['components'] ?? [];

    List<ShakeFormComponent> components = componentsMaps
        .map((c) => ShakeFormComponent.fromMap(c))
        .where((element) => element != null)
        .cast<ShakeFormComponent>()
        .toList();

    return ShakeForm(components);
  }
}
