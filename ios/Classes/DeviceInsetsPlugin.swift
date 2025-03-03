import Flutter
import UIKit

public class DeviceInsetsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_insets", binaryMessenger: registrar.messenger())
    let instance = DeviceInsetsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDeviceInsets":
      let cornerRadius = UIScreen.main.displayCornerRadius
      let corners: [String: Double] = [
        "topLeft": Double(cornerRadius),
        "topRight": Double(cornerRadius),
        "bottomLeft": Double(cornerRadius),
        "bottomRight": Double(cornerRadius)
      ]
      result(corners)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
