package com.accounting.accounting

import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.dropbox/check"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isDropboxInstalled" -> {
                    val isInstalled = isPackageInstalled("com.dropbox.android")
                    result.success(isInstalled)
                }
                "launchDropboxApp" -> {
                    launchDropboxApp()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun isPackageInstalled(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, 0)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun launchDropboxApp() {
        val intent = Intent(Intent.ACTION_VIEW).apply {
            data = Uri.parse("db-7eek2s3zq0o2xkz://") // Use a known Dropbox URI scheme
            setPackage("com.dropbox.android")
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        try {
            startActivity(intent)
        } catch (e: Exception) {
            // If something fails, log or handle here
        }
    }
}
