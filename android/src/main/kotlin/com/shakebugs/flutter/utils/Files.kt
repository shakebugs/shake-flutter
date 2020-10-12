package com.shakebugs.flutter.utils

fun removeExtension(fileName: String?): String? {
    if (fileName == null) {
        return null
    }
    val index = fileName.lastIndexOf('.')
    return if (index == -1 || index == 0) {
        fileName
    } else {
        fileName.substring(0, index)
    }
}