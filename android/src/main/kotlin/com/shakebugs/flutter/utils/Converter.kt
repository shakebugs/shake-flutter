package com.shakebugs.flutter.utils

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
}
