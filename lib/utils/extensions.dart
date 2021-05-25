extension DateUtils on DateTime {
  /// Returns Iso8601 string with timezone.
  String toIsoString() {
    if (timeZoneOffset.isNegative)
      return (toIso8601String() +
          "-${timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(timeZoneOffset.inMinutes - (timeZoneOffset.inHours * 60)).toString().padLeft(2, '0')}");
    else
      return (toIso8601String() +
          "+${timeZoneOffset.inHours.toString().padLeft(2, '0')}:${(timeZoneOffset.inMinutes - (timeZoneOffset.inHours * 60)).toString().padLeft(2, '0')}");
  }
}

extension TextUtils on String {
  /// Checks if contains binary characters.
  bool isBinary() {
    RegExp regex = RegExp(r'\ufffd');
    return regex.hasMatch(this);
  }

  /// Checks if string is a http/https url.
  bool isHttpUrl() {
    if (this.startsWith("https://")) return true;
    if (this.startsWith("http://")) return true;
    return false;
  }
}
