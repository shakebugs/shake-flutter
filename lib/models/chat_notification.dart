/// Represents Shake chat notification.
class ChatNotification {
  String id;
  String userId;
  String title;
  String message;

  ChatNotification(this.id, this.userId, this.title, this.message);

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'message': message,
    };
  }

  /// Converts map to object.
  static ChatNotification fromMap(Map data) {
    String id = data['id'] ?? '';
    String userId = data['userId'] ?? '';
    String title = data['title'] ?? '';
    String message = data['message'] ?? '';

    return ChatNotification(id, userId, title, message);
  }
}
