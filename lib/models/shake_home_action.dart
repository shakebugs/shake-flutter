import 'package:shake_flutter/models/shake_base_action.dart';

/// Represents submit action for Home screen.
class ShakeHomeAction extends ShakeBaseAction {
  ShakeHomeAction(String title, Function? handler,
      {String? subtitle, String? icon})
      : super(title, subtitle, icon, handler, 'default');

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
  static ShakeHomeAction fromMap(Map data) {
    String title = data['title'] ?? '';
    String? titleRes = data['titleRes'];
    String subtitle = data['subtitle'] ?? '';
    String? subtitleRes = data['subtitleRes'];
    String icon = data['icon'] ?? '';
    String? iconRes = data['iconRes'];
    String type = data['type'] ?? '';

    ShakeHomeAction action =
        ShakeHomeAction(title, null, subtitle: subtitle, icon: icon);
    action.titleRes = titleRes;
    action.subtitleRes = subtitleRes;
    action.iconRes = iconRes;
    action.type = type;

    return action;
  }
}
