import 'package:device_insets/device_insets.dart';
import 'package:flutter/material.dart';

void main() async {
  final deviceCornerRadius = await DeviceInsets().getDeviceInsets();

  Material(
    borderRadius: deviceCornerRadius,
  );
}
