import 'package:flutter/widgets.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_insets_method_channel.dart';

abstract class DeviceInsetsPlatform extends PlatformInterface {
  /// Constructs a DeviceInsetsPlatform.
  DeviceInsetsPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceInsetsPlatform _instance = MethodChannelDeviceInsets();

  /// The default instance of [DeviceInsetsPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceInsets].
  static DeviceInsetsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceInsetsPlatform] when
  /// they register themselves.
  static set instance(DeviceInsetsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<BorderRadius> getDeviceInsets() {
    throw UnimplementedError('getDeviceInsets() has not been implemented.');
  }
}
