import 'package:shake_flutter/models/shake_base_action.dart';

/// Represents chat action for Home screen.
class ShakeChatAction extends ShakeBaseAction {
  ShakeChatAction({String? title, String? subtitle, String? icon})
      : super(title, subtitle, icon, null, 'chat');

  /// Converts object to map.
  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'titleRes': titleRes,
      'subtitle': subtitle,
      'subtitleRes': subtitleRes,
      'icon': icon,
      'iconRes': iconRes,
      'type': type,
    };
  }

  /// Converts map to object.
  static ShakeChatAction fromMap(Map data) {
    String title = data['title'] ?? '';
    String? titleRes = data['titleRes'];
    String subtitle = data['subtitle'] ?? '';
    String? subtitleRes = data['subtitleRes'];
    String icon = data['icon'] ?? '';
    String? iconRes = data['iconRes'];
    String type = data['type'] ?? '';

    ShakeChatAction action =
        ShakeChatAction(title: title, subtitle: subtitle, icon: icon);
    action.titleRes = titleRes;
    action.subtitleRes = subtitleRes;
    action.iconRes = iconRes;
    action.type = type;

    return action;
  }
}
