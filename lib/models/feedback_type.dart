/// Represents feedback type.
class FeedbackType {
  String title;
  String tag;
  String icon;

  FeedbackType(this.title, this.tag, [this.icon = ""]);

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tag': tag,
      'icon': icon,
    };
  }

  /// Converts map to object.
  static FeedbackType fromMap(Map data) {
    String title = data['title'] ?? '';
    String tag = data['tag'] ?? '';
    String icon = data['icon'] ?? '';

    return FeedbackType(title, tag, icon);
  }
}
