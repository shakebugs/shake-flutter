package com.shakebugs.flutter.helpers

import android.content.Context
import android.graphics.Color
import com.shakebugs.flutter.utils.Converter
import com.shakebugs.flutter.utils.Converter.resToString
import com.shakebugs.flutter.utils.Converter.stringToRes
import com.shakebugs.flutter.utils.Files
import com.shakebugs.shake.LogLevel
import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.ShakeScreen
import com.shakebugs.shake.form.*
import com.shakebugs.shake.internal.domain.models.NetworkRequest
import com.shakebugs.shake.internal.domain.models.NotificationEvent
import com.shakebugs.shake.report.ShakeFile
import com.shakebugs.shake.theme.ShakeTheme
import io.flutter.FlutterInjector


class Mapper(private val context: Context) {
    fun mapToShakeScreen(shakeScreenStr: String?): ShakeScreen {
        return when (shakeScreenStr) {
            "newTicket" -> ShakeScreen.NEW
            "home" -> ShakeScreen.HOME
            else -> ShakeScreen.NEW
        }
    }

    fun shakeScreenToString(shakeScreen: ShakeScreen): String? {
        return when (shakeScreen) {
            ShakeScreen.HOME -> "home"
            ShakeScreen.NEW -> "newTicket"
            else -> null
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

    fun mapToReportConfiguration(data: HashMap<String, Any>?): ShakeReportConfiguration? {
        var config: ShakeReportConfiguration? = null
        if (data != null) {
            config = ShakeReportConfiguration()
            config.activityHistoryData = data["activityHistoryData"] as Boolean
            config.blackBoxData = data["blackBoxData"] as Boolean
            config.screenshot = data["screenshot"] as Boolean
            config.video = data["video"] as Boolean
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

    fun mapToShakeForm(shakeFormMap: HashMap<String, Any?>?): ShakeForm? {
        if (shakeFormMap == null) return null

        val formComponentsArray: List<Map<String, Any?>> =
            shakeFormMap["components"] as? List<Map<String, Any?>> ?: listOf()

        val formComponents: ArrayList<ShakeFormComponent> = arrayListOf()
        for (componentMap in formComponentsArray) {
            val type: String = componentMap["type"] as String
            if ("title" == type) {
                val label: String = componentMap["label"] as? String ?: ""
                val labelResName: String? = componentMap["labelRes"] as? String
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val labelRes: Int? = stringToRes(context, labelResName, "string")
                formComponents.add(ShakeTitle(label, labelRes, initialValue, required))
            }
            if ("text_input" == type) {
                val label: String = componentMap["label"] as? String ?: ""
                val labelResName: String? = componentMap["labelRes"] as? String
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val labelRes: Int? = stringToRes(context, labelResName, "string")
                formComponents.add(ShakeTextInput(label, labelRes, initialValue, required))
            }
            if ("email" == type) {
                val label: String = componentMap["label"] as? String ?: ""
                val labelResName: String? = componentMap["labelRes"] as? String
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val labelRes: Int? = stringToRes(context, labelResName, "string")
                formComponents.add(ShakeEmail(label, labelRes, initialValue, required))
            }
            if ("picker" == type) {
                val label: String = componentMap["label"] as? String ?: ""
                val labelResName: String? = componentMap["labelRes"] as? String
                val itemsList: List<Map<String, Any?>> =
                    componentMap["items"] as? List<Map<String, Any?>> ?: listOf()

                val items: MutableList<ShakePickerItem> = arrayListOf()
                for (itemMap in itemsList) {
                    val text: String = itemMap["text"] as? String ?: ""
                    val textResName: String? = itemMap["textRes"] as? String
                    val iconResName: String? = itemMap["icon"] as? String
                    val tag: String? = itemMap["tag"] as? String

                    val iconRes: Int? = stringToRes(context, iconResName, "drawable")
                    val textRes: Int? = stringToRes(context, textResName, "string")
                    items.add(ShakePickerItem(iconRes, text, textRes, tag))
                }

                val labelRes: Int? = stringToRes(context, labelResName, "string")
                formComponents.add(ShakePicker(label, labelRes, items))
            }
            if ("attachments" == type) {
                formComponents.add(ShakeAttachments())
            }
            if ("inspect" == type) {
                formComponents.add(ShakeInspectButton())
            }
        }
        return ShakeForm(formComponents)
    }

    fun shakeFormToMap(shakeForm: ShakeForm): Map<String, Any?> {
        val componentsArray: ArrayList<HashMap<String, Any?>> = arrayListOf()
        for (component in shakeForm.components) {
            if (component is ShakeTitle) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type
                componentMap["label"] = component.label
                componentMap["labelRes"] = resToString(context, component.labelRes)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakeTextInput) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type
                componentMap["label"] = component.label
                componentMap["labelRes"] = resToString(context, component.labelRes)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakeEmail) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type
                componentMap["label"] = component.label
                componentMap["labelRes"] = resToString(context, component.labelRes)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakePicker) {
                val items: ArrayList<Map<String, Any?>> = arrayListOf()
                for (item in component.items) {
                    val itemMap: HashMap<String, Any?> = hashMapOf()
                    itemMap["icon"] = resToString(context, item.icon)
                    itemMap["text"] = item.text
                    itemMap["textRes"] = resToString(context, item.textRes)
                    itemMap["tag"] = item.tag

                    items.add(itemMap)
                }

                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type
                componentMap["label"] = component.label
                componentMap["labelRes"] = resToString(context, component.labelRes)
                componentMap["items"] = items

                componentsArray.add(componentMap)
            }
            if (component is ShakeAttachments) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type

                componentsArray.add(componentMap)
            }
            if (component is ShakeInspectButton) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["type"] = component.type

                componentsArray.add(componentMap)
            }
        }
        val shakeFormMap: HashMap<String, Any?> = hashMapOf()
        shakeFormMap["components"] = componentsArray

        return shakeFormMap
    }

    fun mapToShakeTheme(shakeThemeMap: HashMap<String, Any>?): ShakeTheme? {
        if (shakeThemeMap == null) return null

        val fontFamilyBold = shakeThemeMap["fontFamilyBold"] as? String?
        val fontFamilyMedium = shakeThemeMap["fontFamilyMedium"] as? String?
        val backgroundColor = shakeThemeMap["backgroundColor"] as? String?
        val secondaryBackgroundColor = shakeThemeMap["secondaryBackgroundColor"] as? String?
        val textColor = shakeThemeMap["textColor"] as? String?
        val secondaryTextColor = shakeThemeMap["secondaryTextColor"] as? String?
        val accentColor = shakeThemeMap["accentColor"] as? String?
        val accentTextColor = shakeThemeMap["accentTextColor"] as? String?
        val outlineColor = shakeThemeMap["outlineColor"] as? String?
        val borderRadius = shakeThemeMap["borderRadius"] as? Double?
        val elevation = shakeThemeMap["elevation"] as? Double?

        val shakeTheme = ShakeTheme()
        shakeTheme.fontFamilyBoldValue = findAssetPath(fontFamilyBold)
        shakeTheme.fontFamilyMediumValue = findAssetPath(fontFamilyMedium)
        shakeTheme.backgroundColorValue = Color.parseColor(backgroundColor)
        shakeTheme.secondaryBackgroundColorValue = Color.parseColor(secondaryBackgroundColor)
        shakeTheme.textColorValue = Color.parseColor(textColor)
        shakeTheme.secondaryTextColorValue = Color.parseColor(secondaryTextColor)
        shakeTheme.accentColorValue = Color.parseColor(accentColor)
        shakeTheme.accentTextColorValue = Color.parseColor(accentTextColor)
        shakeTheme.outlineColorValue = Color.parseColor(outlineColor)
        shakeTheme.borderRadiusValue = borderRadius?.toFloat()
        shakeTheme.elevationValue = elevation?.toFloat()

        return shakeTheme
    }

    private fun findAssetPath(assetName: String?): String? {
        if (assetName == null) return null

        val loader = FlutterInjector.instance().flutterLoader()
        return loader.getLookupKeyForAsset(assetName)
    }
}
