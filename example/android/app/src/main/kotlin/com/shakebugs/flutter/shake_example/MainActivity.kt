package com.shakebugs.flutter.shake_example

import android.view.MotionEvent
import com.shakebugs.shake.Shake
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun dispatchTouchEvent(ev: MotionEvent?): Boolean {
        Shake.handleTouchEvent(ev, this)
        return super.dispatchTouchEvent(ev)
    }
}
