import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_insets/device_insets_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDeviceInsets platform = MethodChannelDeviceInsets();
  const MethodChannel channel = MethodChannel('device_insets');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          'topLeft': 12,
          'topRight': 34,
          'bottomLeft': 56,
          'bottomRight': 78
        };
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getDeviceInsets', () async {
    expect(await platform.getDeviceInsets(), isA<BorderRadius>());
  });
}
