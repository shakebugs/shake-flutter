package com.shakebugs.flutter

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.shakebugs.flutter.utils.Constants
import com.shakebugs.flutter.utils.Logger
import com.shakebugs.flutter.utils.Mappers
import com.shakebugs.shake.Shake
import com.shakebugs.shake.ShakeInfo
import com.shakebugs.shake.internal.data.NetworkRequest
import com.shakebugs.shake.internal.data.NotificationEvent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** ShakePlugin */
class ShakePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private var activity: Activity? = null

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "shake")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
        activity = activityPluginBinding.activity
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

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "shake")
            channel.setMethodCallHandler(ShakePlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "start" -> start(call)
            "show" -> show()
            "setEnabled" -> setEnabled(call)
            "setEnableBlackBox" -> setEnableBlackBox(call)
            "isEnableBlackBox" -> isEnableBlackBox(result)
            "setEnableActivityHistory" -> setEnableActivityHistory(call)
            "isEnableActivityHistory" -> isEnableActivityHistory(result)
            "setEnableInspectScreen" -> setEnableInspectScreen(call)
            "isEnableInspectScreen" -> isEnableInspectScreen(result)
            "setShowFloatingReportButton" -> setShowFloatingReportButton(call)
            "isShowFloatingReportButton" -> isShowFloatingReportButton(result)
            "setInvokeShakeOnShakeDeviceEvent" -> setInvokeShakeOnShakeDeviceEvent(call)
            "isInvokeShakeOnShakeDeviceEvent" -> isInvokeShakeOnShakeDeviceEvent(result)
            "setInvokeShakeOnScreenshot" -> setInvokeShakeOnScreenshot(call)
            "isInvokeShakeOnScreenshot" -> isInvokeShakeOnScreenshot(result)
            "getEmailField" -> getEmailField(result)
            "setEmailField" -> setEmailField(call)
            "isEnableEmailField" -> isEnableEmailField(result)
            "setEnableEmailField" -> setEnableEmailField(call)
            "isEnableMultipleFeedbackTypes" -> isEnableMultipleFeedbackTypes(result)
            "setEnableMultipleFeedbackTypes" -> setEnableMultipleFeedbackTypes(call)
            "getShowIntroMessage" -> getShowIntroMessage(result)
            "setShowIntroMessage" -> setShowIntroMessage(call)
            "isAutoVideoRecording" -> isAutoVideoRecording(result)
            "setAutoVideoRecording" -> setAutoVideoRecording(call)
            "isConsoleLogsEnabled" -> isConsoleLogsEnabled(result)
            "setConsoleLogsEnabled" -> setConsoleLogsEnabled(call)
            "log" -> log(call)
            "setMetadata" -> setMetadata(call)
            "setShakeReportData" -> setShakeReportData(call)
            "silentReport" -> silentReport(call)
            "insertNetworkRequest" -> insertNetworkRequest(call)
            "insertNotificationEvent" -> insertNotificationEvent(call)
            "isSensitiveDataRedactionEnabled" -> isSensitiveDataRedactionEnabled(result)
            "setSensitiveDataRedactionEnabled" -> setSensitiveDataRedactionEnabled(call)
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

        startNotificationsEmitter();
    }

    private fun show() {
        Shake.show()
    }

    private fun setEnabled(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.setEnabled(enabled)
        }
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

    private fun setEnableInspectScreen(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isEnableInspectScreen = it
        }
    }

    private fun isEnableInspectScreen(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableInspectScreen
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

    private fun setShakeReportData(call: MethodCall) {
        val shakeFiles: List<HashMap<String, Any>>? = call.argument("shakeFiles")

        Shake.onPrepareData { Mappers.mapToShakeFiles(shakeFiles) }
    }

    private fun silentReport(call: MethodCall) {
        val description: String? = call.argument("description")
        val shakeFilesMap: List<HashMap<String, Any>>? = call.argument("shakeFiles")
        val configMap: HashMap<String, Any>? = call.argument("configuration")

        val shakeFiles = Mappers.mapToShakeFiles(shakeFilesMap)
        val config = Mappers.mapToShakeReportConfiguration(configMap)

        Shake.silentReport(description, { shakeFiles }, config)
    }

    private fun setMetadata(call: MethodCall) {
        val key: String? = call.argument("key")
        val value: String? = call.argument("value")

        Shake.setMetadata(key, value)
    }

    private fun log(call: MethodCall) {
        val logLevelStr: String? = call.argument("level")
        val message: String? = call.argument("message")

        val logLevel = Mappers.mapToLogLevel(logLevelStr)
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

    private fun isEnableEmailField(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isEnableEmailField
        result.success(enabled)
    }

    private fun setEnableEmailField(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isEnableEmailField = it
        }
    }

    private fun getEmailField(result: Result) {
        val email: String = Shake.getReportConfiguration().emailField
        result.success(email)
    }

    private fun setEmailField(call: MethodCall) {
        val email: String? = call.argument("email")
        email?.let {
            Shake.getReportConfiguration().emailField = email
        }
    }

    private fun isEnableMultipleFeedbackTypes(result: Result) {
        val enabled: Boolean = Shake.getReportConfiguration().isFeedbackTypeEnabled
        result.success(enabled)
    }

    private fun setEnableMultipleFeedbackTypes(call: MethodCall) {
        val enabled: Boolean? = call.argument("enabled")
        enabled?.let {
            Shake.getReportConfiguration().isFeedbackTypeEnabled = it
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
            val notificationEvent: NotificationEvent = Mappers.mapToNotificationEvent(it)
            ShakeReflection.insertNotificationEvent(notificationEvent)
        }
    }

    private fun insertNetworkRequest(call: MethodCall) {
        val networkRequestMap: HashMap<String, Any>? = call.argument("networkRequest")
        networkRequestMap?.let {
            val networkRequest: NetworkRequest = Mappers.mapToNetworkRequest(it)
            ShakeReflection.insertNetworkRequest(networkRequest)
        }
    }

    private fun startNotificationsEmitter() {
        Shake.setNotificationEventsFilter {
            val map = Mappers.notificationEventToMap(it.build());
            channel.invokeMethod("onNotificationReceived", map)

            null
        }
    }

    private fun showNotificationsSettings() {
        activity?.startActivity(Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"))
    }
}
