/// Represents Shake form Picker item.
class ShakePickerItem {
  String text;
  String? textRes;
  String? icon;
  String? tag;

  ShakePickerItem(this.text, {this.textRes, this.icon, this.tag});

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'textRes': textRes,
      'icon': icon,
      'tag': tag,
    };
  }

  /// Converts map to object.
  static ShakePickerItem fromMap(Map data) {
    String text = data['text'] ?? '';
    String? textRes = data['textRes'];
    String? icon = data['icon'];
    String? tag = data['tag'];

    return ShakePickerItem(text, textRes: textRes, icon: icon, tag: tag);
  }
}
