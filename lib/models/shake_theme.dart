import 'dart:ui';

/// Represents Shake UI theme.
class ShakeTheme {
  String? fontFamilyMedium;

  String? fontFamilyBold;

  String? backgroundColor;

  String? secondaryBackgroundColor;

  String? textColor;

  String? secondaryTextColor;

  String? accentColor;

  String? accentTextColor;

  String? outlineColor;

  double? borderRadius;

  double? elevation;

  double? shadowRadius;

  double? shadowOpacity;

  Offset? shadowOffset;

  ShakeTheme();

  /// Converts object to map.
  Map<String, dynamic> toMap() {
    return {
      "fontFamilyMedium": fontFamilyMedium,
      "fontFamilyBold": fontFamilyBold,
      "backgroundColor": backgroundColor,
      "secondaryBackgroundColor": secondaryBackgroundColor,
      "textColor": textColor,
      "secondaryTextColor": secondaryTextColor,
      "accentColor": accentColor,
      "accentTextColor": accentTextColor,
      "outlineColor": outlineColor,
      "borderRadius": borderRadius,
      "elevation": elevation,
      "shadowRadius": shadowRadius,
      "shadowOpacity": shadowOpacity,
      "shadowOffsetWidth": shadowOffset?.dx,
      "shadowOffsetHeight": shadowOffset?.dy,
    };
  }
}
