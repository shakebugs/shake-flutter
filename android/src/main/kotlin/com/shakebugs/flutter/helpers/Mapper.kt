package com.shakebugs.flutter.helpers

import android.content.Context
import com.shakebugs.flutter.utils.Converter
import com.shakebugs.flutter.utils.Files
import com.shakebugs.flutter.utils.Resources
import com.shakebugs.shake.LogLevel
import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.ShakeScreen
import com.shakebugs.shake.internal.data.NetworkRequest
import com.shakebugs.shake.internal.data.NotificationEvent
import com.shakebugs.shake.report.FeedbackType
import com.shakebugs.shake.report.ShakeFile


class Mapper(private val context: Context) {
    fun mapToShakeScreen(shakeScreenStr: String?): ShakeScreen {
        return when (shakeScreenStr) {
            "newTicket" -> ShakeScreen.NEW
            "home" -> ShakeScreen.HOME
            else -> ShakeScreen.NEW
        }
    }

    fun mapToShakeFiles(data: List<HashMap<String, Any>>?): List<ShakeFile>? {
        return data?.map {
            val path: String = it["path"] as String
            var name: String = it["name"] as String
            name = Files.removeExtension(name)

            ShakeFile(name, path)
        }
    }

    fun mapToFeedbackTypes(data: List<HashMap<String, Any>>?): List<FeedbackType>? {
        return data?.map {
            val title: String = it["title"] as String
            val tag: String = it["tag"] as String
            val icon: String? = it["icon"] as String?

            val iconRes: Int = Resources.getResourceId(context, icon)

            val feedbackType =
                if (iconRes != 0) FeedbackType(iconRes, title, tag) else FeedbackType(title, tag)
            feedbackType
        }
    }

    fun feedbackTypesToMap(feedbackTypes: List<FeedbackType>?): List<Map<String, String>>? {
        return feedbackTypes?.map { feedbackType ->
            val title: String = feedbackType.title ?: context.getString(feedbackType.titleRes)
            val tag: String = feedbackType.tag
            val icon: Int = feedbackType.icon

            val iconName: String = Resources.getResourceName(context, icon)

            mapOf("icon" to iconName, "title" to title, "tag" to tag)
        }
    }

    fun mapToReportConfiguration(data: HashMap<String, Any>?): ShakeReportConfiguration? {
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

    fun mapToNotificationEvent(data: HashMap<String, Any>): NotificationEvent {
        val id = data["id"] as? String ?: ""
        val title = data["title"] as? String ?: ""
        val description = data["description"] as? String ?: ""

        val notificationEvent = NotificationEvent()
        notificationEvent.id = Converter.stringToInt(id)
        notificationEvent.title = title
        notificationEvent.description = description

        return notificationEvent
    }

    fun notificationEventToMap(notificationEvent: NotificationEvent): Map<String, String> {
        val id = notificationEvent.id.toString()
        val title = notificationEvent.title ?: ""
        val description = notificationEvent.description ?: ""

        return mapOf("id" to id, "title" to title, "description" to description)
    }

    fun mapToNetworkRequest(data: HashMap<String, Any>): NetworkRequest {
        val networkRequest = NetworkRequest()
        networkRequest.method = data["method"] as String
        networkRequest.url = data["url"] as String
        networkRequest.statusCode = data["status"] as String
        networkRequest.requestBody = data["requestBody"] as String
        networkRequest.responseBody = data["responseBody"] as String
        networkRequest.requestHeaders = data["requestHeaders"] as Map<String, String>
        networkRequest.responseHeaders = data["responseHeaders"] as Map<String, String>
        networkRequest.timestamp = data["timestamp"] as String
        networkRequest.duration = (data["duration"] as Int).toFloat()

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
