package com.shakebugs.flutter

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.Intent
import com.shakebugs.flutter.helpers.Mapper
import com.shakebugs.flutter.utils.Constants
import com.shakebugs.shake.Shake
import com.shakebugs.shake.ShakeInfo
import com.shakebugs.shake.ShakeScreen
import com.shakebugs.shake.chat.ChatNotification
import com.shakebugs.shake.chat.UnreadChatMessagesListener
import com.shakebugs.shake.form.ShakeForm
import com.shakebugs.shake.internal.domain.models.NetworkRequest
import com.shakebugs.shake.internal.domain.models.NotificationEvent
import com.shakebugs.shake.theme.ShakeTheme
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** ShakePlugin */
class ShakePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var context: Context? = null
    private var mapper: Mapper? = null

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "shake")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        mapper = Mapper(context!!)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        context = activityPluginBinding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        context = null
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
        context = activityPluginBinding.activity
    }

    override fun onDetachedFromActivity() {
        context = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "start" -> start(call, result)
            "getShakeForm" -> getShakeForm(call, result)
            "setShakeForm" -> setShakeForm(call, result)
            "setShakeTheme" -> setShakeTheme(call, result)
            "setHomeSubtitle" -> setHomeSubtitle(call, result)
            "show" -> show(call, result)
            "isUserFeedbackEnabled" -> isUserFeedbackEnabled(call, result)
            "setUserFeedbackEnabled" -> setUserFeedbackEnabled(call, result)
            "setEnableBlackBox" -> setEnableBlackBox(call, result)
            "isEnableBlackBox" -> isEnableBlackBox(call, result)
            "setEnableActivityHistory" -> setEnableActivityHistory(call, result)
            "isEnableActivityHistory" -> isEnableActivityHistory(call, result)
            "setShowFloatingReportButton" -> setShowFloatingReportButton(call, result)
            "isShowFloatingReportButton" -> isShowFloatingReportButton(call, result)
            "setInvokeShakeOnShakeDeviceEvent" -> setInvokeShakeOnShakeDeviceEvent(call, result)
            "isInvokeShakeOnShakeDeviceEvent" -> isInvokeShakeOnShakeDeviceEvent(call, result)
            "setShakingThreshold" -> setShakingThreshold(call, result)
            "getShakingThreshold" -> getShakingThreshold(call, result)
            "setInvokeShakeOnScreenshot" -> setInvokeShakeOnScreenshot(call, result)
            "isInvokeShakeOnScreenshot" -> isInvokeShakeOnScreenshot(call, result)
            "getDefaultScreen" -> getDefaultScreen(call, result)
            "setDefaultScreen" -> setDefaultScreen(call, result)
            "setScreenshotIncluded" -> setScreenshotIncluded(call, result)
            "isScreenshotIncluded" -> isScreenshotIncluded(call, result)
            "getShowIntroMessage" -> getShowIntroMessage(call, result)
            "setShowIntroMessage" -> setShowIntroMessage(call, result)
            "isAutoVideoRecording" -> isAutoVideoRecording(call, result)
            "setAutoVideoRecording" -> setAutoVideoRecording(call, result)
            "isConsoleLogsEnabled" -> isConsoleLogsEnabled(call, result)
            "setConsoleLogsEnabled" -> setConsoleLogsEnabled(call, result)
            "log" -> log(call, result)
            "setMetadata" -> setMetadata(call, result)
            "clearMetadata" -> clearMetadata(call, result)
            "setShakeReportData" -> setShakeReportData(call, result)
            "silentReport" -> silentReport(call, result)
            "registerUser" -> registerUser(call, result)
            "updateUserId" -> updateUserId(call, result)
            "updateUserMetadata" -> updateUserMetadata(call, result)
            "unregisterUser" -> unregisterUser(call, result)
            "insertNetworkRequest" -> insertNetworkRequest(call, result)
            "insertNotificationEvent" -> insertNotificationEvent(call, result)
            "isSensitiveDataRedactionEnabled" -> isSensitiveDataRedactionEnabled(call, result)
            "setSensitiveDataRedactionEnabled" -> setSensitiveDataRedactionEnabled(call, result)
            "startUnreadMessagesEmitter" -> startUnreadMessagesEmitter(call, result)
            "showNotificationsSettings" -> showNotificationsSettings(call, result)
            "setPushNotificationsToken" -> setPushNotificationsToken(call, result)
            "showChatNotification" -> showChatNotification(call, result)
            else -> result.notImplemented()
        }
    }

    /**
     * Passed to the native SDK to distinguish native and Flutter apps.
     *
     * @return platform info
     */
    private fun buildShakePlatformInfo(): ShakeInfo {
        val platformInfo = ShakeInfo()
        platformInfo.platform = Constants.PLATFORM
        platformInfo.versionCode = Constants.VERSION_CODE
        platformInfo.versionName = Constants.VERSION_NAME
        return platformInfo
    }

    private fun start(call: MethodCall, result: Result) {
        val clientId: String? = call.argument("clientId")
        val clientSecret: String? = call.argument("clientSecret")

        ShakeReflection.setShakeInfo(buildShakePlatformInfo())

        when (context) {
            is Activity -> ShakeReflection.start(context as Activity, clientId, clientSecret)
            is Application -> Shake.start(context as Application, clientId, clientSecret)
        }

        startNotificationsEmitter()

        result.success(null)
    }

    private fun getShakeForm(call: MethodCall, result: Result) {
        val shakeForm: ShakeForm = Shake.getReportConfiguration().shakeForm
        val shakeFormMap: Map<String, Any?> = mapper?.shakeFormToMap(shakeForm) ?: mapOf()

        result.success(shakeFormMap)
    }

    private fun setShakeForm(call: MethodCall, result: Result) {
        val shakeFormMap: HashMap<String, Any?>? = call.argument("shakeForm")
        val shakeForm = mapper?.mapToShakeForm(shakeFormMap)
        Shake.getReportConfiguration().shakeForm = shakeForm

        result.success(null)
    }

    private fun setShakeTheme(call: MethodCall, result: Result) {
        val shakeThemeMap: HashMap<String, Any>? = call.argument("shakeTheme")
        val shakeTheme: ShakeTheme? = mapper?.mapToShakeTheme(shakeThemeMap)
        Shake.getReportConfiguration().theme = shakeTheme

        result.success(null)
    }

    private fun setHomeSubtitle(call: MethodCall, result: Result) {
        val subtitle: String? = call.argument("subtitle")
        Shake.getReportConfiguration().homeSubtitleValue = subtitle

        result.success(null)
    }

    private fun show(call: MethodCall, result: Result) {
        val shakeScreenArg: String? = call.argument("shakeScreen")

        val shakeScreen = mapper?.mapToShakeScreen(shakeScreenArg)
        shakeScreen?.let { Shake.show(shakeScreen) }

        result.success(null)
    }

    private fun setUserFeedbackEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.setUserFeedbackEnabled(enabled) }

        result.success(null)
    }

    private fun isUserFeedbackEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.isUserFeedbackEnabled()
        result.success(enabled)
    }

    private fun setEnableBlackBox(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isEnableBlackBox = it }

        result.success(null)
    }

    private fun isEnableBlackBox(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableBlackBox

        result.success(enabled)
    }

    private fun setEnableActivityHistory(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isEnableActivityHistory = it }

        result.success(null)
    }

    private fun isEnableActivityHistory(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableActivityHistory

        result.success(enabled)
    }

    private fun setShowFloatingReportButton(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isShowFloatingReportButton = it }

        result.success(null)
    }

    private fun isShowFloatingReportButton(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isShowFloatingReportButton
        result.success(enabled)
    }

    private fun setInvokeShakeOnShakeDeviceEvent(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isInvokeShakeOnShakeDeviceEvent = it }

        result.success(null)
    }

    private fun isInvokeShakeOnShakeDeviceEvent(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnShakeDeviceEvent

        result.success(enabled)
    }

    private fun getDefaultScreen(call: MethodCall, result: Result) {
        val defaultScreen: ShakeScreen = Shake.getReportConfiguration().defaultScreen
        val defaultScreenStr: String = mapper?.shakeScreenToString(defaultScreen) ?: "newTicket"

        result.success(defaultScreenStr)
    }

    private fun setDefaultScreen(call: MethodCall, result: Result) {
        val defaultScreenStr: String? = call.argument("shakeScreen")
        val defaultScreen: ShakeScreen? = mapper?.mapToShakeScreen(defaultScreenStr)
        defaultScreen?.let { Shake.getReportConfiguration().defaultScreen = defaultScreen }

        result.success(null)
    }

    private fun getShakingThreshold(call: MethodCall, result: Result) {
        val threshold: Int = Shake.getReportConfiguration().shakingThreshold

        result.success(threshold)
    }

    private fun setShakingThreshold(call: MethodCall, result: Result) {
        val threshold: Int? = call.argument("shakingThreshold")
        threshold?.let { Shake.getReportConfiguration().shakingThreshold = threshold }

        result.success(null)
    }

    private fun setInvokeShakeOnScreenshot(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isInvokeShakeOnScreenshot = it }

        result.success(null)
    }

    private fun isInvokeShakeOnScreenshot(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnScreenshot

        result.success(enabled)
    }

    private fun isScreenshotIncluded(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isScreenshotIncluded

        result.success(enabled)
    }

    private fun setScreenshotIncluded(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isScreenshotIncluded = it }

        result.success(null)
    }

    private fun setShakeReportData(call: MethodCall, result: Result) {
        val shakeFilesArg: List<HashMap<String, Any>>? = call.argument("shakeFiles")
        shakeFilesArg?.let { shakeFiles -> Shake.onPrepareData { mapper?.mapToShakeFiles(shakeFiles) } }

        result.success(null)
    }

    private fun silentReport(call: MethodCall, result: Result) {
        val description: String? = call.argument("description")
        val shakeFilesArg: List<HashMap<String, Any>>? = call.argument("shakeFiles")
        val configurationArg: HashMap<String, Any>? = call.argument("configuration")

        val shakeFiles = mapper?.mapToShakeFiles(shakeFilesArg)
        val config = mapper?.mapToReportConfiguration(configurationArg)

        Shake.silentReport(description, { shakeFiles }, config)

        result.success(null)
    }

    private fun registerUser(call: MethodCall, result: Result) {
        val userId: String? = call.argument("userId")
        Shake.registerUser(userId)

        result.success(null)
    }

    private fun updateUserId(call: MethodCall, result: Result) {
        val userId: String? = call.argument("userId")
        Shake.updateUserId(userId)

        result.success(null)
    }

    private fun updateUserMetadata(call: MethodCall, result: Result) {
        val metadata: Map<String, String>? = call.argument("metadata")
        Shake.updateUserMetadata(metadata)

        result.success(null)
    }

    private fun unregisterUser(call: MethodCall, result: Result) {
        Shake.unregisterUser()

        result.success(null)
    }

    private fun setMetadata(call: MethodCall, result: Result) {
        val key: String? = call.argument("key")
        val value: String? = call.argument("value")
        Shake.setMetadata(key, value)

        result.success(null)
    }

    private fun clearMetadata(call: MethodCall, result: Result) {
        Shake.clearMetadata()

        result.success(null)
    }

    private fun log(call: MethodCall, result: Result) {
        val logLevelStr: String? = call.argument("level")
        val message: String? = call.argument("message")

        val logLevel = mapper?.mapToLogLevel(logLevelStr)
        Shake.log(logLevel, message)

        result.success(null)
    }

    private fun isAutoVideoRecording(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isAutoVideoRecording
        result.success(enabled)
    }

    private fun setAutoVideoRecording(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isAutoVideoRecording = it }

        result.success(null)
    }

    private fun isConsoleLogsEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isConsoleLogsEnabled
        result.success(enabled)
    }

    private fun setConsoleLogsEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isConsoleLogsEnabled = it }

        result.success(null)
    }

    private fun getShowIntroMessage(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getShowIntroMessage()

        result.success(enabled)
    }

    private fun setShowIntroMessage(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.setShowIntroMessage(it) }

        result.success(null)
    }

    private fun isSensitiveDataRedactionEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isSensitiveDataRedactionEnabled

        result.success(enabled)
    }

    private fun setSensitiveDataRedactionEnabled(call: MethodCall, result: Result) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let { Shake.getReportConfiguration().isSensitiveDataRedactionEnabled = it }

        result.success(null)
    }

    private fun insertNotificationEvent(call: MethodCall, result: Result) {
        val notificationEventMap: HashMap<String, Any>? = call.argument("notificationEvent")
        notificationEventMap?.let {
            val notificationEvent: NotificationEvent? = mapper?.mapToNotificationEvent(it)
            ShakeReflection.insertNotificationEvent(notificationEvent)
        }

        result.success(null)
    }

    private fun insertNetworkRequest(call: MethodCall, result: Result) {
        val networkRequestMap: HashMap<String, Any>? = call.argument("networkRequest")
        networkRequestMap?.let {
            val networkRequest: NetworkRequest? = mapper?.mapToNetworkRequest(it)
            ShakeReflection.insertNetworkRequest(networkRequest)
        }

        result.success(null)
    }

    private fun startUnreadMessagesEmitter(call: MethodCall, result: Result) {
        Shake.setUnreadChatMessagesListener(object : UnreadChatMessagesListener {
            override fun onUnreadMessagesCountChanged(count: Int) {
                channel.invokeMethod("onUnreadMessagesReceived", count)
            }
        })

        result.success(null)
    }

    private fun startNotificationsEmitter() {
        Shake.setNotificationEventsFilter {
            val map = mapper?.notificationEventToMap(it.build())
            channel.invokeMethod("onNotificationReceived", map)

            null
        }
    }

    private fun showNotificationsSettings(call: MethodCall, result: Result) {
        context?.startActivity(Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"))

        result.success(null)
    }

    private fun setPushNotificationsToken(call: MethodCall, result: Result) {
        val token: String? = call.argument("token")
        Shake.setPushNotificationsToken(token)

        result.success(null)
    }

    private fun showChatNotification(call: MethodCall, result: Result) {
        val chatNotificationMap: HashMap<String, Any>? = call.argument("chatNotification")
        chatNotificationMap?.let {
            val chatNotification: ChatNotification? = mapper?.mapToChatNotification(it)
            Shake.showChatNotification(chatNotification)
        }

        result.success(null)
    }
}
