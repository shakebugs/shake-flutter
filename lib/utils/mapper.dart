import 'package:shake_flutter/models/feedback_type.dart';
import 'package:shake_flutter/models/shake_file.dart';

class Mapper {
  /// Converts list of [FeedbackType] to list of maps.
  List<Map<String, dynamic>>? feedbackTypesToMap(
      List<FeedbackType>? feedbackTypes) {
    return feedbackTypes?.map((feedbackType) => feedbackType.toMap()).toList();
  }

  /// Converts list of maps to list of [FeedbackType].
  List<FeedbackType>? mapToFeedbackTypes(List<Map>? feedbackTypesMaps) {
    return feedbackTypesMaps?.map((map) => FeedbackType.fromMap(map)).toList();
  }

  /// Converts list of [ShakeFile] to list of maps.
  List<Map<String, dynamic>> shakeFilesToMap(List<ShakeFile> shakeFiles) {
    return shakeFiles.map((shakeFile) => shakeFile.toMap()).toList();
  }
}
