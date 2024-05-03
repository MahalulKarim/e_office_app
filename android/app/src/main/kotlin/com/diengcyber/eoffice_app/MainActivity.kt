package com.diengcyber.eoffice_app
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.annotation.NonNull // Pastikan impor ini ada jika Anda memang membutuhkannya

class MainActivity : FlutterActivity() {
    private val CHANNEL = "social_channel_s4i"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startApp") {
                val packageName = call.argument<String>("package")
                if (packageName != null) {
                    val pm = applicationContext.packageManager
                    val intent: Intent? = pm.getLaunchIntentForPackage(packageName)
                    if (intent != null) {
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        applicationContext.startActivity(intent)
                        result.success("Success")
                    } else {
                        result.error("NOT_FOUND", "Package not found", null)
                    }
                } else {
                    result.error("INVALID_PACKAGE", "Invalid package name", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}

