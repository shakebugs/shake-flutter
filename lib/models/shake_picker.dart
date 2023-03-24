import 'package:shake_flutter/models/shake_form_component.dart';
import 'package:shake_flutter/models/shake_picker_item.dart';

/// Represents Shake form Picker.
class ShakePicker extends ShakeFormComponent {
  String label;
  List<ShakePickerItem> items;
  String? labelRes;

  ShakePicker(this.label, this.items, {this.labelRes}) : super('picker');

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> itemsMaps = items.map((c) => c.toMap()).toList();

    return {
      'type': type,
      'label': label,
      'items': itemsMaps,
      'labelRes': labelRes,
    };
  }

  /// Converts map to object.
  static ShakePicker fromMap(Map data) {
    String label = data['label'] ?? '';
    List<dynamic> itemsMaps = data['items'] ?? [];
    String? labelRes = data['labelRes'];

    List<ShakePickerItem> items =
        itemsMaps.map((c) => ShakePickerItem.fromMap(c)).toList();

    return ShakePicker(label, items, labelRes: labelRes);
  }
}
