package com.metajet.android_storage

import android.content.Context
import android.os.Build
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class AndroidStoragePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_storage")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val targetSdkVersion = context.applicationInfo?.targetSdkVersion ?: 0
    when(call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${Build.VERSION.SDK_INT}")
      }
      "getExternalStorageDirectory" -> {
        if(targetSdkVersion <= Build.VERSION_CODES.Q) {
          result.success(Environment.getExternalStorageDirectory().toString())
        } else {
          result.success(context.getExternalFilesDir(null).toString())
        }
      }
      "getExternalStoragePublicDirectory" -> {
        val type = call.argument<String>("type")
        if(targetSdkVersion <= Build.VERSION_CODES.Q) {
          result.success(Environment.getExternalStoragePublicDirectory(type).toString());
        } else {
          result.success(context.getExternalFilesDir(type).toString())
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
