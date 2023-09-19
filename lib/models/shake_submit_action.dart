import 'package:shake_flutter/models/shake_base_action.dart';

/// Represents submit action for Home screen.
class ShakeSubmitAction extends ShakeBaseAction {
  ShakeSubmitAction({String? title, String? subtitle, String? icon})
      : super(title, subtitle, icon, null, 'submit');

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
  static ShakeSubmitAction fromMap(Map data) {
    String title = data['title'] ?? '';
    String? titleRes = data['titleRes'];
    String subtitle = data['subtitle'] ?? '';
    String? subtitleRes = data['subtitleRes'];
    String icon = data['icon'] ?? '';
    String? iconRes = data['iconRes'];
    String type = data['type'] ?? '';

    ShakeSubmitAction action =
        ShakeSubmitAction(title: title, subtitle: subtitle, icon: icon);
    action.titleRes = titleRes;
    action.subtitleRes = subtitleRes;
    action.iconRes = iconRes;
    action.type = type;

    return action;
  }
}
