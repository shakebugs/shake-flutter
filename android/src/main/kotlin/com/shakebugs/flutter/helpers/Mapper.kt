package com.shakebugs.flutter.helpers

import android.content.Context
import com.shakebugs.flutter.utils.Converter
import com.shakebugs.flutter.utils.Converter.convertBase64ToDrawable
import com.shakebugs.flutter.utils.Converter.convertDpToPixel
import com.shakebugs.flutter.utils.Converter.convertDrawableToBase64
import com.shakebugs.flutter.utils.Converter.resToString
import com.shakebugs.flutter.utils.Converter.stringToColor
import com.shakebugs.flutter.utils.Converter.stringToRes
import com.shakebugs.flutter.utils.Files
import com.shakebugs.shake.LogLevel
import com.shakebugs.shake.ShakeReportConfiguration
import com.shakebugs.shake.ShakeScreen
import com.shakebugs.shake.chat.ChatNotification
import com.shakebugs.shake.form.ShakeAttachments
import com.shakebugs.shake.form.ShakeEmail
import com.shakebugs.shake.form.ShakeForm
import com.shakebugs.shake.form.ShakeFormComponent
import com.shakebugs.shake.form.ShakeInspectButton
import com.shakebugs.shake.form.ShakePicker
import com.shakebugs.shake.form.ShakePickerItem
import com.shakebugs.shake.form.ShakeTextInput
import com.shakebugs.shake.form.ShakeTitle
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
                val key: String = componentMap["key"] as? String ?: ""
                val label: String? = componentMap["label"] as? String?
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val comp = ShakeTitle(key, label, initialValue, required)
                comp.label = stringToRes(context, componentMap["labelRes"] as? String, "string")

                formComponents.add(comp)
            }
            if ("text_input" == type) {
                val key: String = componentMap["key"] as? String ?: ""
                val label: String? = componentMap["label"] as? String?
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val comp = ShakeTextInput(key, label, initialValue, required)
                comp.label = stringToRes(context, componentMap["labelRes"] as? String, "string")

                formComponents.add(comp)
            }
            if ("email" == type) {
                val key: String = componentMap["key"] as? String ?: ""
                val label: String? = componentMap["label"] as? String?
                val initialValue: String = componentMap["initialValue"] as? String ?: ""
                val required: Boolean = componentMap["required"] as? Boolean ?: false

                val comp = ShakeEmail(key, label, initialValue, required)
                comp.label = stringToRes(context, componentMap["labelRes"] as? String, "string")

                formComponents.add(comp)
            }
            if ("picker" == type) {
                val itemsList: List<Map<String, Any?>> =
                    componentMap["items"] as? List<Map<String, Any?>> ?: listOf()
                val items: MutableList<ShakePickerItem> = arrayListOf()
                for (itemMap in itemsList) {
                    val key: String = itemMap["key"] as? String ?: ""
                    val text: String? = itemMap["text"] as? String?
                    val icon: String? = itemMap["icon"] as? String?
                    val tag: String? = itemMap["tag"] as? String

                    val item =
                        ShakePickerItem(key, text, convertBase64ToDrawable(context, icon), tag)
                    item.icon = stringToRes(context, itemMap["iconRes"] as? String, "drawable")
                    item.text = stringToRes(context, itemMap["textRes"] as? String, "string")

                    items.add(item)
                }

                val key: String = componentMap["key"] as? String ?: ""
                val label: String? = componentMap["label"] as? String?

                val comp = ShakePicker(key, label, items)
                comp.label = stringToRes(context, componentMap["labelRes"] as? String, "string")

                formComponents.add(comp)
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
                componentMap["key"] = component.key
                componentMap["type"] = component.type
                componentMap["label"] = component.labelValue
                componentMap["labelRes"] = resToString(context, component.label)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakeTextInput) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["key"] = component.key
                componentMap["type"] = component.type
                componentMap["label"] = component.labelValue
                componentMap["labelRes"] = resToString(context, component.label)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakeEmail) {
                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["key"] = component.key
                componentMap["type"] = component.type
                componentMap["label"] = component.labelValue
                componentMap["labelRes"] = resToString(context, component.label)
                componentMap["initialValue"] = component.initialValue
                componentMap["required"] = component.required

                componentsArray.add(componentMap)
            }
            if (component is ShakePicker) {
                val items: ArrayList<Map<String, Any?>> = arrayListOf()
                for (item in component.items) {
                    val itemMap: HashMap<String, Any?> = hashMapOf()
                    itemMap["key"] = item.key
                    itemMap["text"] = item.textValue
                    itemMap["textRes"] = resToString(context, item.text)
                    itemMap["icon"] = convertDrawableToBase64(item.iconValue)
                    itemMap["iconRes"] = resToString(context, item.icon)
                    itemMap["tag"] = item.tag

                    items.add(itemMap)
                }

                val componentMap: HashMap<String, Any?> = hashMapOf()
                componentMap["key"] = component.key
                componentMap["type"] = component.type
                componentMap["label"] = component.labelValue
                componentMap["labelRes"] = resToString(context, component.label)
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
        shakeTheme.backgroundColorValue = stringToColor(backgroundColor)
        shakeTheme.secondaryBackgroundColorValue = stringToColor(secondaryBackgroundColor)
        shakeTheme.textColorValue = stringToColor(textColor)
        shakeTheme.secondaryTextColorValue = stringToColor(secondaryTextColor)
        shakeTheme.accentColorValue = stringToColor(accentColor)
        shakeTheme.accentTextColorValue = stringToColor(accentTextColor)
        shakeTheme.outlineColorValue = stringToColor(outlineColor)
        shakeTheme.borderRadiusValue = convertDpToPixel(context, borderRadius?.toFloat())
        shakeTheme.elevationValue = convertDpToPixel(context, elevation?.toFloat())

        return shakeTheme
    }

    fun mapToChatNotification(data: HashMap<String, Any>): ChatNotification? {
        var chatNotification: ChatNotification? = null

        try {
            val id: String? = data["id"] as? String?
            val userId: String? = data["userId"] as? String?
            val title: String? = data["title"] as? String?
            val message: String? = data["message"] as? String?
            if (id != null && userId != null && title != null && message != null) {
                chatNotification = ChatNotification(id, userId, title, message)
            }
        } catch (ignore: Exception) {
        }

        return chatNotification
    }

    private fun findAssetPath(assetName: String?): String? {
        if (assetName == null) return null

        val loader = FlutterInjector.instance().flutterLoader()
        return loader.getLookupKeyForAsset(assetName)
    }
}
