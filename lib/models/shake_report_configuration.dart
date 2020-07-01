class ShakeReportConfiguration {
  bool blackBoxData = true;
  bool activityHistoryData = true;
  bool screenshot = true;
  bool showReportSentMessage = false;

  Map<String, dynamic> toMap() {
    return {
      "blackBoxData": blackBoxData,
      "activityHistoryData": activityHistoryData,
      "screenshot": screenshot,
      "showReportSentMessage": showReportSentMessage,
    };
  }
}
