package com.shakebugs.flutter.utils

import android.content.Context

object Resources {

    /**
     * Gets resource name from resource id.
     */
    fun getResourceName(context: Context, resourceId: Int): String {
        var resourceName = ""
        try {
            resourceName = context.resources.getResourceEntryName(resourceId)
        } catch (ignore: Exception) {
        }
        return resourceName
    }

    /**
     * Gets resource id from resource name.
     */
    fun getResourceId(context: Context, resourceName: String?, type: String = "drawable"): Int {
        var resourceId = 0;
        try {
            resourceId = context.resources.getIdentifier(resourceName, type, context.packageName)
        } catch (e: Exception) {
        }
        return resourceId;
    }
}