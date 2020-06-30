package com.shakebugs.flutter.shake.utils

import com.shakebugs.shake.report.ShakeFile

fun mapToShakeFiles(data: List<HashMap<String, Any>>?): List<ShakeFile>? {
    return data?.mapNotNull {
        val name: String? = it["name"].toString()
        val path: String? = it["path"].toString()

        if (name != null && path != null) {
            return@mapNotNull ShakeFile(name, path)
        }
        null
    }
}