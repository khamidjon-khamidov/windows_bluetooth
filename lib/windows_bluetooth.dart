
import 'dart:async';

import 'package:flutter/services.dart';

class WindowsBluetooth {
  static const MethodChannel _channel = MethodChannel('windows_bluetooth');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
