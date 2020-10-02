extension DateUtils on DateTime {
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
  bool isBinary() {
    RegExp multibyte = RegExp(r'[^\x00-\x7F]');
    return multibyte.hasMatch(this);
  }
}