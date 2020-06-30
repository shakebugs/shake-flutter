package com.shakebugs.flutter.shake

import android.app.Application
import android.util.Log
import androidx.annotation.NonNull
import com.shakebugs.flutter.shake.utils.mapToShakeFiles
import com.shakebugs.shake.Shake
import com.shakebugs.shake.report.ShakeFile
import com.shakebugs.shake.report.ShakeReportData
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


/** ShakePlugin */
public class ShakePlugin : FlutterPlugin, MethodCallHandler {
    private var application: Application? = null

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        application = flutterPluginBinding.applicationContext as Application

        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "shake")
        channel.setMethodCallHandler(this);
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
            "start" -> {
                Shake.start(application)
            }
            "show" -> {
                Shake.show()
            }
            "setEnabled" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.setEnabled(enabled)
                }
            }
            "setEnableBlackBox" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().enableBlackBox = it
                }
            }
            "isEnableBlackBox" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isEnableBlackBox
                result.success(enabled)
            }
            "setEnableActivityHistory" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().enableActivityHistory = it
                }
            }
            "isEnableActivityHistory" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isEnableActivityHistory
                result.success(enabled)
            }
            "setEnableInspectScreen" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().enableInspectScreen = it
                }
            }
            "isEnableInspectScreen" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isEnableInspectScreen
                result.success(enabled)
            }
            "setShowFloatingReportButton" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().isShowFloatingReportButton = it
                }
            }
            "isShowFloatingReportButton" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isShowFloatingReportButton
                result.success(enabled)
            }
            "setInvokeShakeOnShaking" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().invokeShakeOnShakeDeviceEvent = it
                }
            }
            "isInvokeShakeOnShaking" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnShakeDeviceEvent
                result.success(enabled)
            }
            "setInvokeShakeOnScreenshot" -> {
                val enabled: Boolean? = call.argument("enabled")
                enabled?.let {
                    Shake.getReportConfiguration().invokeShakeOnScreenshot = it
                }
            }
            "isInvokeShakeOnScreenshot" -> {
                val enabled: Boolean = Shake.getReportConfiguration().isInvokeShakeOnScreenshot
                result.success(enabled)
            }
            "setShakeReportData" -> {
                val quickFacts: String? = call.argument("quickFacts")
                val filesData: List<HashMap<String, Any>>? = call.argument("shakeFiles")

                Shake.onPrepareData(object : ShakeReportData {
                    override fun quickFacts(): String? {
                        return quickFacts
                    }

                    override fun attachedFiles(): List<ShakeFile>? {
                        return mapToShakeFiles(filesData)
                    }
                });
            }
            "silentReport" -> {
                Log.i("Shake", "silentReport() is not supported in Flutter 10 SDK.");
            }
            "insertNetworkRequest" -> {
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
