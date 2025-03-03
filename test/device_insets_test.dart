import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_insets/device_insets.dart';
import 'package:device_insets/device_insets_platform_interface.dart';
import 'package:device_insets/device_insets_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInsetsPlatform
    with MockPlatformInterfaceMixin
    implements DeviceInsetsPlatform {
  @override
  Future<BorderRadius> getDeviceInsets() {
    return Future.value(BorderRadius.circular(12));
  }
}

void main() {
  final DeviceInsetsPlatform initialPlatform = DeviceInsetsPlatform.instance;

  test('$MethodChannelDeviceInsets is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceInsets>());
  });

  test('getDeviceInsets', () async {
    DeviceInsets deviceInsetsPlugin = DeviceInsets();
    MockDeviceInsetsPlatform fakePlatform = MockDeviceInsetsPlatform();
    DeviceInsetsPlatform.instance = fakePlatform;

    expect(await deviceInsetsPlugin.getDeviceInsets(), isA<BorderRadius>());
  });
}
