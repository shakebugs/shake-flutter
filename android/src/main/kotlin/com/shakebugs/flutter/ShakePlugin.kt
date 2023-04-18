package com.shakebugs.flutter

import android.app.Activity
import android.content.Intent
import com.shakebugs.flutter.helpers.Mapper
import com.shakebugs.flutter.utils.Constants
import com.shakebugs.flutter.utils.Logger
import com.shakebugs.shake.Shake
import com.shakebugs.shake.ShakeInfo
import com.shakebugs.shake.ShakeScreen
import com.shakebugs.shake.chat.UnreadChatMessagesListener
import com.shakebugs.shake.form.ShakeForm
import com.shakebugs.shake.internal.domain.models.NetworkRequest
import com.shakebugs.shake.internal.domain.models.NotificationEvent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ShakePlugin */
class ShakePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var activity: Activity? = null
    private var mapper: Mapper? = null

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "shake")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        activity = activityPluginBinding.activity
        mapper = Mapper(activityPluginBinding.activity.applicationContext)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(activityPluginBinding: ActivityPluginBinding) {
        activity = activityPluginBinding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "start" -> start(call)
            "getShakeForm" -> getShakeForm(result)
            "setShakeForm" -> setShakeForm(call)
            "show" -> show(call)
            "isUserFeedbackEnabled" -> isUserFeedbackEnabled(result)
            "setUserFeedbackEnabled" -> setUserFeedbackEnabled(call)
            "setEnableBlackBox" -> setEnableBlackBox(call)
            "isEnableBlackBox" -> isEnableBlackBox(result)
            "setEnableActivityHistory" -> setEnableActivityHistory(call)
            "isEnableActivityHistory" -> isEnableActivityHistory(result)
            "setShowFloatingReportButton" -> setShowFloatingReportButton(call)
            "isShowFloatingReportButton" -> isShowFloatingReportButton(result)
            "setInvokeShakeOnShakeDeviceEvent" -> setInvokeShakeOnShakeDeviceEvent(call)
            "isInvokeShakeOnShakeDeviceEvent" -> isInvokeShakeOnShakeDeviceEvent(result)
            "setShakingThreshold" -> setShakingThreshold(call)
            "getShakingThreshold" -> getShakingThreshold(result)
            "setInvokeShakeOnScreenshot" -> setInvokeShakeOnScreenshot(call)
            "isInvokeShakeOnScreenshot" -> isInvokeShakeOnScreenshot(result)
            "getDefaultScreen" -> getDefaultScreen(result)
            "setDefaultScreen" -> setDefaultScreen(call)
            "setScreenshotIncluded" -> setScreenshotIncluded(call)
            "isScreenshotIncluded" -> isScreenshotIncluded(result)
            "getShowIntroMessage" -> getShowIntroMessage(result)
            "setShowIntroMessage" -> setShowIntroMessage(call)
            "isAutoVideoRecording" -> isAutoVideoRecording(result)
            "setAutoVideoRecording" -> setAutoVideoRecording(call)
            "isConsoleLogsEnabled" -> isConsoleLogsEnabled(result)
            "setConsoleLogsEnabled" -> setConsoleLogsEnabled(call)
            "log" -> log(call)
            "setMetadata" -> setMetadata(call)
            "clearMetadata" -> clearMetadata()
            "setShakeReportData" -> setShakeReportData(call)
            "silentReport" -> silentReport(call)
            "registerUser" -> registerUser(call)
            "updateUserId" -> updateUserId(call)
            "updateUserMetadata" -> updateUserMetadata(call)
            "unregisterUser" -> unregisterUser()
            "insertNetworkRequest" -> insertNetworkRequest(call)
            "insertNotificationEvent" -> insertNotificationEvent(call)
            "isSensitiveDataRedactionEnabled" -> isSensitiveDataRedactionEnabled(result)
            "setSensitiveDataRedactionEnabled" -> setSensitiveDataRedactionEnabled(call)
            "startUnreadMessagesEmitter" -> startUnreadMessagesEmitter()
            "showNotificationsSettings" -> showNotificationsSettings()
            else -> result.notImplemented()
        }
    }

    private fun start(call: MethodCall) {
        val clientId: String? = call.argument("clientId")
        val clientSecret: String? = call.argument("clientSecret")

        if (activity == null) {
            Logger.e("Activity not initialized.")
            return
        }

        val shakeInfo = ShakeInfo()
        shakeInfo.platform = Constants.PLATFORM
        shakeInfo.versionCode = Constants.VERSION_CODE
        shakeInfo.versionName = Constants.VERSION_NAME

        ShakeReflection.setShakeInfo(shakeInfo)
        ShakeReflection.start(activity, clientId, clientSecret)

        startNotificationsEmitter()
    }

    private fun getShakeForm(result: Result) {
        val shakeForm: ShakeForm = Shake.getReportConfiguration().shakeForm
        val shakeFormMap: Map<String, Any?> = mapper?.shakeFormToMap(shakeForm) ?: mapOf()
        result.success(shakeFormMap)
    }

    private fun setShakeForm(call: MethodCall) {
        val shakeFormArgs: HashMap<String, Any?>? = call.argument("shakeForm")
        shakeFormArgs?.let {
            val shakeForm = mapper?.mapToShakeForm(shakeFormArgs)
            Shake.getReportConfiguration().shakeForm = shakeForm
        }
    }

    private fun show(call: MethodCall) {
        val shakeScreenArg: String? = call.argument("shakeScreen")

        val shakeScreen = mapper?.mapToShakeScreen(shakeScreenArg)
        shakeScreen?.let {
            Shake.show(shakeScreen)
        }
    }

    private fun setUserFeedbackEnabled(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.setUserFeedbackEnabled(enabled)
        }
    }

    private fun isUserFeedbackEnabled(result: Result) {
        val enabled: Boolean = Shake.isUserFeedbackEnabled()
        result.success(enabled)
    }

    private fun setEnableBlackBox(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isEnableBlackBox = it
        }
    }

    private fun isEnableBlackBox(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableBlackBox
        result.success(enabled)
    }

    private fun setEnableActivityHistory(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isEnableActivityHistory = it
        }
    }

    private fun isEnableActivityHistory(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableActivityHistory
        result.success(enabled)
    }

    private fun setShowFloatingReportButton(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isShowFloatingReportButton = it
        }
    }

    private fun isShowFloatingReportButton(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isShowFloatingReportButton
        result.success(enabled)
    }

    private fun setInvokeShakeOnShakeDeviceEvent(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isInvokeShakeOnShakeDeviceEvent = it
        }
    }

    private fun isInvokeShakeOnShakeDeviceEvent(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnShakeDeviceEvent
        result.success(enabled)
    }

    private fun getDefaultScreen(result: Result) {
        val defaultScreen: ShakeScreen = Shake.getReportConfiguration().defaultScreen
        val defaultScreenStr: String = mapper?.shakeScreenToString(defaultScreen) ?: "newTicket"
        result.success(defaultScreenStr)
    }

    private fun setDefaultScreen(call: MethodCall) {
        val defaultScreenStr: String? = call.argument("shakeScreen")
        val defaultScreen: ShakeScreen? = mapper?.mapToShakeScreen(defaultScreenStr)
        defaultScreen?.let {
            Shake.getReportConfiguration().defaultScreen = defaultScreen
        }
    }

    private fun getShakingThreshold(result: Result) {
        val threshold: Int = Shake.getReportConfiguration().shakingThreshold
        result.success(threshold)
    }

    private fun setShakingThreshold(call: MethodCall) {
        val threshold: Int? = call.argument("shakingThreshold")
        threshold?.let {
            Shake.getReportConfiguration().shakingThreshold = threshold
        }
    }

    private fun setInvokeShakeOnScreenshot(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isInvokeShakeOnScreenshot = it
        }
    }

    private fun isInvokeShakeOnScreenshot(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnScreenshot
        result.success(enabled)
    }

    private fun isScreenshotIncluded(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isScreenshotIncluded
        result.success(enabled)
    }

    private fun setScreenshotIncluded(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isScreenshotIncluded = it
        }
    }

    private fun setShakeReportData(call: MethodCall) {
        val shakeFilesArg: List<HashMap<String, Any>>? = call.argument("shakeFiles")
        shakeFilesArg?.let { shakeFiles ->
            Shake.onPrepareData { mapper?.mapToShakeFiles(shakeFiles) }
        }
    }

    private fun silentReport(call: MethodCall) {
        val description: String? = call.argument("description")
        val shakeFilesArg: List<HashMap<String, Any>>? = call.argument("shakeFiles")
        val configurationArg: HashMap<String, Any>? = call.argument("configuration")

        val shakeFiles = mapper?.mapToShakeFiles(shakeFilesArg)
        val config = mapper?.mapToReportConfiguration(configurationArg)

        Shake.silentReport(description, { shakeFiles }, config)
    }

    private fun registerUser(call: MethodCall) {
        val userId: String? = call.argument("userId")

        Shake.registerUser(userId)
    }

    private fun updateUserId(call: MethodCall) {
        val userId: String? = call.argument("userId")

        Shake.updateUserId(userId)
    }

    private fun updateUserMetadata(call: MethodCall) {
        val metadata: Map<String, String>? = call.argument("metadata")

        Shake.updateUserMetadata(metadata)
    }

    private fun unregisterUser() {
        Shake.unregisterUser()
    }

    private fun setMetadata(call: MethodCall) {
        val key: String? = call.argument("key")
        val value: String? = call.argument("value")

        Shake.setMetadata(key, value)
    }

    private fun clearMetadata() {
        Shake.clearMetadata()
    }

    private fun log(call: MethodCall) {
        val logLevelStr: String? = call.argument("level")
        val message: String? = call.argument("message")

        val logLevel = mapper?.mapToLogLevel(logLevelStr)
        Shake.log(logLevel, message)
    }

    private fun isAutoVideoRecording(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isAutoVideoRecording
        result.success(enabled)
    }

    private fun setAutoVideoRecording(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isAutoVideoRecording = it
        }
    }

    private fun isConsoleLogsEnabled(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isConsoleLogsEnabled
        result.success(enabled)
    }

    private fun setConsoleLogsEnabled(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isConsoleLogsEnabled = it
        }
    }

    private fun getShowIntroMessage(result: Result) {
        val enabled: Boolean = Shake.getShowIntroMessage()
        result.success(enabled)
    }

    private fun setShowIntroMessage(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.setShowIntroMessage(it)
        }
    }

    private fun isSensitiveDataRedactionEnabled(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isSensitiveDataRedactionEnabled
        result.success(enabled)
    }

    private fun setSensitiveDataRedactionEnabled(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isSensitiveDataRedactionEnabled = it
        }
    }

    private fun insertNotificationEvent(call: MethodCall) {
        val notificationEventMap: HashMap<String, Any>? = call.argument("notificationEvent")
        notificationEventMap?.let {
            val notificationEvent: NotificationEvent? = mapper?.mapToNotificationEvent(it)
            ShakeReflection.insertNotificationEvent(notificationEvent)
        }
    }

    private fun insertNetworkRequest(call: MethodCall) {
        val networkRequestMap: HashMap<String, Any>? = call.argument("networkRequest")
        networkRequestMap?.let {
            val networkRequest: NetworkRequest? = mapper?.mapToNetworkRequest(it)
            ShakeReflection.insertNetworkRequest(networkRequest)
        }
    }

    private fun startUnreadMessagesEmitter() {
        Shake.setUnreadChatMessagesListener(object : UnreadChatMessagesListener {
            override fun onUnreadMessagesCountChanged(count: Int) {
                channel.invokeMethod("onUnreadMessagesReceived", count)
            }
        })
    }

    private fun startNotificationsEmitter() {
        Shake.setNotificationEventsFilter {
            val map = mapper?.notificationEventToMap(it.build())
            channel.invokeMethod("onNotificationReceived", map)

            null
        }
    }

    private fun showNotificationsSettings() {
        activity?.startActivity(Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"))
    }
}
