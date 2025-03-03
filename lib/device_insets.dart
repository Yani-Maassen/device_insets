import 'package:flutter/widgets.dart';

import 'device_insets_platform_interface.dart';

class DeviceInsets {
  Future<BorderRadius> getDeviceInsets() {
    return DeviceInsetsPlatform.instance.getDeviceInsets();
  }
}
