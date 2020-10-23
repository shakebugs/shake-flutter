package com.shakebugs.flutter.utils

import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.internal.data.NetworkRequest
import com.shakebugs.shake.report.ShakeFile

fun mapToShakeFiles(data: List<HashMap<String, Any>>?): List<ShakeFile>? {
    return data?.mapNotNull {
        val path: String? = it["path"] as String
        var name: String? = it["name"] as String
        name = removeExtension(name)

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

fun mapToNetworkRequest(data: HashMap<String, Any>?): NetworkRequest? {
    var networkRequest: NetworkRequest? = null
    if (data != null) {
        networkRequest = NetworkRequest()
        networkRequest.method = data["method"] as String
        networkRequest.url = data["url"] as String
        networkRequest.statusCode = data["status"] as String
        networkRequest.requestBody = data["requestBody"] as String
        networkRequest.responseBody = data["responseBody"] as String
        networkRequest.requestHeaders = data["requestHeaders"] as Map<String, String>
        networkRequest.responseHeaders = data["responseHeaders"] as Map<String, String>
        networkRequest.timestamp = data["timestamp"] as String
        networkRequest.duration = (data["duration"] as Int).toFloat()
    }
    return networkRequest
}