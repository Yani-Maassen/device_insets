package com.yanim.device_insets

import android.app.Activity
import android.os.Build
import android.view.RoundedCorner
import android.view.WindowInsets
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DeviceInsetsPlugin */
class DeviceInsetsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel: MethodChannel
  private var activity: Activity? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_insets")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.S)
  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getDeviceInsets") {
      if (activity == null) {
        result.error("NO_ACTIVITY", "Activity is not available", null)
        return
      }

      val window = activity!!.window
      val view = window.decorView

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        val insets = view.rootWindowInsets
        val build: MutableMap<String, Any> = HashMap()
        build["topLeft"] = insets?.getRoundedCorner(RoundedCorner.POSITION_TOP_LEFT)?.radius ?: 0
        build["topRight"] = insets?.getRoundedCorner(RoundedCorner.POSITION_TOP_RIGHT)?.radius ?: 0
        build["bottomLeft"] = insets?.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_LEFT)?.radius ?: 0
        build["bottomRight"] = insets?.getRoundedCorner(RoundedCorner.POSITION_BOTTOM_RIGHT)?.radius ?: 0

        result.success(build)
      } else {
        result.notImplemented()
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}
