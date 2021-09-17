import 'dart:async';
import 'dart:typed_data';

import 'package:windows_bluetooth_platform_interface/windows_bluetooth_platform_interface.dart';

import 'models.dart';

export 'package:windows_bluetooth/models.dart';

export 'models.dart';

class WindowsBluetooth {
  static Future<bool> isBluetoothAvailable() =>
      WindowsBluetoothPlatform.instance.isBluetoothAvailable();

  static void startScan() => WindowsBluetoothPlatform.instance.startScan();

  static void stopScan() => WindowsBluetoothPlatform.instance.stopScan();

  static Stream<BlueScanResult> get scanResultStream {
    return WindowsBluetoothPlatform.instance.scanResultStream
        .map((item) => BlueScanResult.fromMap(item));
  }

  static void connect(String deviceId) =>
      WindowsBluetoothPlatform.instance.connect(deviceId);

  static void disconnect(String deviceId) =>
      WindowsBluetoothPlatform.instance.disconnect(deviceId);

  static void setConnectionHandler(OnConnectionChanged onConnectionChanged) {
    WindowsBluetoothPlatform.instance.onConnectionChanged = onConnectionChanged;
  }

  static void discoverServices(String deviceId) =>
      WindowsBluetoothPlatform.instance.discoverServices(deviceId);

  static void setServiceHandler(OnServiceDiscovered onServiceDiscovered) {
    WindowsBluetoothPlatform.instance.onServiceDiscovered = onServiceDiscovered;
  }

  static Future<void> setNotifiable(String deviceId, String service,
      String characteristic, BleInputProperty bleInputProperty) {
    return WindowsBluetoothPlatform.instance
        .setNotifiable(deviceId, service, characteristic, bleInputProperty);
  }

  static void setValueHandler(OnValueChanged onValueChanged) {
    WindowsBluetoothPlatform.instance.onValueChanged = onValueChanged;
  }

  static Future<void> writeValue(
      String deviceId,
      String service,
      String characteristic,
      Uint8List value,
      BleOutputProperty bleOutputProperty) {
    return WindowsBluetoothPlatform.instance.writeValue(
        deviceId, service, characteristic, value, bleOutputProperty);
  }

  static Future<int> requestMtu(String deviceId, int expectedMtu) =>
      WindowsBluetoothPlatform.instance.requestMtu(deviceId, expectedMtu);
}
