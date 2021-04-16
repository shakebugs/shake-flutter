package com.shakebugs.flutter.utils

import com.shakebugs.shake.LogLevel
import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.internal.data.NetworkRequest
import com.shakebugs.shake.internal.data.NotificationEvent
import com.shakebugs.shake.report.ShakeFile

object Mappers {
    fun mapToShakeFiles(data: List<HashMap<String, Any>>?): List<ShakeFile>? {
        return data?.mapNotNull {
            val path: String? = it["path"] as String
            var name: String? = it["name"] as String
            name = Files.removeExtension(name)

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

    fun mapToNotificationEvent(data: HashMap<String, Any>?): NotificationEvent? {
        var notificationEvent: NotificationEvent? = null
        if (data != null) {
            notificationEvent = NotificationEvent()
            notificationEvent.id = data["id"] as Int
            notificationEvent.title = data["title"] as String
            notificationEvent.description = data["description"] as String
        }

        return notificationEvent
    }

    fun notificationEventToMap(notificationEvent: NotificationEvent): Map<String, String> {
        return mapOf<String, String>(
                "id" to notificationEvent.id.toString(),
                "title" to notificationEvent.title,
                "description" to notificationEvent.description
        )
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

    fun mapToLogLevel(logLevelString: String?): LogLevel {
        return when (logLevelString) {
            "verbose" -> LogLevel.VERBOSE
            "debug" -> LogLevel.DEBUG
            "info" -> LogLevel.INFO
            "warn" -> LogLevel.WARN
            "error" -> LogLevel.ERROR
            else -> {
                LogLevel.INFO
            }
        }
    }
}
