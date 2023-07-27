/// Represents base action for Home screen.
abstract class ShakeBaseAction {
  String? title;
  String? titleRes;
  String? subtitle;
  String? subtitleRes;
  String? icon;
  String? iconRes;
  Function? handler;
  String? type;

  ShakeBaseAction(
      this.title, this.subtitle, this.icon, this.handler, this.type);

  Map<String, dynamic> toMap();
}
