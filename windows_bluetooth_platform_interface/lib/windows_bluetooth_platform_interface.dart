library windows_bluetooth_platform_interface;

import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// import 'method_channel_quick_blue.dart';
import 'method_channel_windows_bluetooth.dart';
import 'models.dart';

export 'models.dart';

typedef OnConnectionChanged = void Function(
    String deviceId, BlueConnectionState state);

typedef OnServiceDiscovered = void Function(String deviceId, String serviceId);

typedef OnValueChanged = void Function(
    String deviceId, String characteristicId, Uint8List value);

abstract class WindowsBluetoothPlatform extends PlatformInterface {
  WindowsBluetoothPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowsBluetoothPlatform _instance = MethodChannelWindowsBluetooth();

  static WindowsBluetoothPlatform get instance => _instance;

  static set instance(WindowsBluetoothPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  OnConnectionChanged? onConnectionChanged;

  Stream<dynamic> get scanResultStream;

  OnServiceDiscovered? onServiceDiscovered;

  OnValueChanged? onValueChanged;

  Future<bool> isBluetoothAvailable();

  void startScan();

  void stopScan();

  void connect(String deviceId);

  void disconnect(String deviceId);

  void discoverServices(String deviceId);

  Future<void> setNotifiable(String deviceId, String service,
      String characteristic, BleInputProperty bleInputProperty);

  Future<void> writeValue(
      String deviceId,
      String service,
      String characteristic,
      Uint8List value,
      BleOutputProperty bleOutputProperty);

  Future<int> requestMtu(String deviceId, int expectedMtu);
}
