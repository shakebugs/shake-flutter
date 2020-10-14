/// Silent report configuration.
///
/// Set [blackBoxData] to include or exclude black-box from bug report.
/// Set [activityHistoryData] to include or exclude activity from bug report.
/// Set [screenshot] to include or exclude screenshot from bug report.
/// Use [showReportSentMessage] to display or hide bug reported message.
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
