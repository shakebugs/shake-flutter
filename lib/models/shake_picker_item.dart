/// Represents Shake form Picker item.
class ShakePickerItem {
  String key;
  String? text;
  String? icon;
  String? tag;
  String? textRes;
  String? iconRes;

  ShakePickerItem(this.key, this.text,
      {this.icon, this.tag, this.textRes, this.iconRes});

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'text': text,
      'icon': icon,
      'tag': tag,
      'textRes': textRes,
      'iconRes': iconRes,
    };
  }

  /// Converts map to object.
  static ShakePickerItem fromMap(Map data) {
    String key = data['key'] ?? '';
    String? text = data['text'];
    String? icon = data['icon'];
    String? tag = data['tag'];
    String? textRes = data['textRes'];
    String? iconRes = data['iconRes'];

    return ShakePickerItem(key, text,
        icon: icon, tag: tag, textRes: textRes, iconRes: iconRes);
  }
}
