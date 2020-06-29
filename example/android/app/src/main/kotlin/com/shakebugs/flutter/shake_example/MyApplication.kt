package com.shakebugs.flutter.shake_example

import com.shakebugs.shake.Shake
import io.flutter.app.FlutterApplication

class MyApplication : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        Shake.start(this)
    }
}