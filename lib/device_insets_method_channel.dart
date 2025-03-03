import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'device_insets_platform_interface.dart';

/// An implementation of [DeviceInsetsPlatform] that uses method channels.
class MethodChannelDeviceInsets extends DeviceInsetsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_insets');

  @override
  Future<BorderRadius> getDeviceInsets() async {
    final map = await methodChannel.invokeMethod('getDeviceInsets');
    return BorderRadius.only(
      topLeft: Radius.circular((map['topLeft'] as num).toDouble()),
      topRight: Radius.circular((map['topRight'] as num).toDouble()),
      bottomLeft: Radius.circular((map['bottomLeft'] as num).toDouble()),
      bottomRight: Radius.circular((map['bottomRight'] as num).toDouble()),
    );
  }
}
