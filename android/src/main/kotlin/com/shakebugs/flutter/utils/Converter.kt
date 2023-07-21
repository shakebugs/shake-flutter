package com.shakebugs.flutter.utils

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Base64
import android.util.DisplayMetrics
import com.shakebugs.flutter.utils.Logger.w
import java.io.ByteArrayOutputStream


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
        } catch (ignore: Exception) {
        }
        return icon
    }

    @SuppressLint("DiscouragedApi")
    fun stringToRes(context: Context, resName: String?, type: String?): Int? {
        if (resName == null) return null
        var iconRes: Int? = null
        try {
            iconRes = context.resources.getIdentifier(resName, type, context.packageName)
        } catch (ignore: Exception) {
        }
        return iconRes
    }

    fun convertBase64ToDrawable(context: Context, base64String: String?): Drawable? {
        var drawable: Drawable? = null
        try {
            val decodedBytes: ByteArray = Base64.decode(base64String, Base64.DEFAULT)
            val decodedBitmap = BitmapFactory.decodeByteArray(decodedBytes, 0, decodedBytes.size)
            drawable = BitmapDrawable(context.resources, decodedBitmap)
        } catch (ignore: Exception) {
        }
        return drawable
    }

    fun convertDrawableToBase64(drawable: Drawable?): String? {
        var result: String? = null
        try {
            if (drawable is BitmapDrawable) {
                val bitmap = drawable.bitmap
                val byteArrayOutputStream = ByteArrayOutputStream()
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream)
                val byteArray = byteArrayOutputStream.toByteArray()
                result = Base64.encodeToString(byteArray, Base64.DEFAULT)
            }
        } catch (ignore: Exception) {
        }
        return result
    }

    fun convertDpToPixel(context: Context, dp: Float?): Float? {
        if (dp == null) return null
        return dp * (context.resources.displayMetrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT)
    }

    fun convertPixelsToDp(context: Context, px: Float?): Float? {
        if (px == null) return null
        return px / (context.resources.displayMetrics.densityDpi.toFloat() / DisplayMetrics.DENSITY_DEFAULT)
    }

    fun stringToColor(color: String?): Int? {
        return if (color == null) null else Color.parseColor(color)
    }
}
