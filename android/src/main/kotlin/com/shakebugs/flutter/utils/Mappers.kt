package com.shakebugs.flutter.utils

import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.report.ShakeFile

fun mapToShakeFiles(data: List<HashMap<String, Any>>?): List<ShakeFile>? {
    return data?.mapNotNull {
        val name: String? = it["name"] as String
        val path: String? = it["path"] as String

        if (name != null && path != null) {
            return@mapNotNull ShakeFile(name, path)
        }
        null
    }
}

fun mapToShakeReportConfiguration(data: HashMap<String, Any>?): ShakeReportConfiguration? {
    var config: ShakeReportConfiguration? = null
    if (data != null) {
        config = ShakeReportConfiguration()
        config.activityHistoryData = data["activityHistoryData"] as Boolean
        config.blackBoxData = data["blackBoxData"] as Boolean
        config.screenshot = data["screenshot"] as Boolean
        config.showReportSentMessage = data["showReportSentMessage"] as Boolean
    }
    return config
}