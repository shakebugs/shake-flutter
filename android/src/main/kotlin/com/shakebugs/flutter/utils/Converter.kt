package com.shakebugs.flutter.utils

import android.annotation.SuppressLint
import android.content.Context
import android.util.DisplayMetrics
import com.shakebugs.flutter.utils.Logger.w

object Converter {
    fun stringToInt(string: String): Int {
        var result = 0
        try {
            result = string.toInt()
        } catch (e: Exception) {
            w("Notification id is not a valid integer.")
        }
        return result
    }

    fun resToString(context: Context, resourceId: Int?): String? {
        if (resourceId == null) return null
        var icon: String? = null
        try {
            icon = context.resources.getResourceEntryName(resourceId)
        } catch (ignore: java.lang.Exception) {
        }
        return icon
    }

    @SuppressLint("DiscouragedApi")
    fun stringToRes(context: Context, resName: String?, type: String?): Int? {
        if (resName == null) return null
        var iconRes: Int? = null
        try {
            iconRes = context.resources.getIdentifier(resName, type, context.packageName)
        } catch (ignore: java.lang.Exception) {
        }
        return iconRes
    }

    fun convertDpToPixel(context: Context, dp: Float?): Float? {
        if (dp == null) return null
        return dp * (context.resources.displayMetrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT)
    }

    fun convertPixelsToDp(context: Context, px: Float?): Float? {
        if (px == null) return null
        return px / (context.resources.displayMetrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT)
    }
}
