package com.vernacularmedium.ems

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.widget.Toast
import io.flutter.plugin.common.MethodChannel
import com.vernacularmedium.ems.config.Channels
import android.view.WindowManager.LayoutParams


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Channels.toastChannel).setMethodCallHandler { call, result ->
            if (call.method == "toast") {
                val message = call.argument<String>("message")
                val isLong = call.argument<Boolean>("isLong")
                Toast.makeText(applicationContext, message, if (isLong!!) Toast.LENGTH_LONG else Toast.LENGTH_SHORT).show()
                result.success(true)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Channels.securityChannel).setMethodCallHandler { call, result ->
            if (call.method == "enableSecurity") {
                try {
                    window.addFlags(LayoutParams.FLAG_SECURE)
                    result.success(true)
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "enable security error", null)
                }
            } else if (call.method == "disableSecurity") {
                try {
                    window.clearFlags(LayoutParams.FLAG_SECURE)
                    result.success(true)
                } catch (e: Exception) {
                    result.error("UNAVAILABLE", "disable security error", null)
                }

            } else {
                result.notImplemented()
            }
        }


    }
}
