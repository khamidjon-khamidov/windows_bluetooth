import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:windows_bluetooth_platform_interface/windows_bluetooth_platform_interface.dart';

const MethodChannel _channel = const MethodChannel('windows_bluetooth/method');

class MethodChannelWindowsBluetooth extends WindowsBluetoothPlatform {
  static const _event_scanResult =
      const EventChannel('quick_blue/event.scanResult');
  static const _message_connector = const BasicMessageChannel(
      'quick_blue/message.connector', StandardMessageCodec());

  MethodChannelQuickBlue() {
    _message_connector.setMessageHandler(_handleConnectorMessage);
  }

  @override
  Future<bool> isBluetoothAvailable() async =>
      (await _channel.invokeMethod<bool>('isBluetoothAvailable')) ?? false;

  @override
  void startScan() {
    _channel
        .invokeMethod('startScan')
        .then((_) => print('startScan invokeMethod success'));
  }

  @override
  void stopScan() {
    _channel
        .invokeMethod('stopScan')
        .then((_) => print('stopScan invokeMethod success'));
  }

  Stream<dynamic> _scanResultStream =
      _event_scanResult.receiveBroadcastStream({'name': 'scanResult'});

  @override
  Stream<dynamic> get scanResultStream => _scanResultStream;

  @override
  void connect(String deviceId) {
    _channel.invokeMethod('connect', {
      'deviceId': deviceId,
    }).then((_) => print('connect invokeMethod success'));
  }

  @override
  void disconnect(String deviceId) {
    _channel.invokeMethod('disconnect', {
      'deviceId': deviceId,
    }).then((_) => print('disconnect invokeMethod success'));
  }

  @override
  void discoverServices(String deviceId) {
    _channel.invokeMethod('discoverServices', {
      'deviceId': deviceId,
    }).then((_) => print('discoverServices invokeMethod success'));
  }

  Future<void> _handleConnectorMessage(dynamic message) {
    print('_handleConnectorMessage $message');
    if (message['ConnectionState'] != null) {
      String deviceId = message['deviceId'];
      BlueConnectionState connectionState =
          BlueConnectionState.parse(message['ConnectionState']);
      onConnectionChanged?.call(deviceId, connectionState);
    } else if (message['ServiceState'] != null) {
      if (message['ServiceState'] == 'discovered') {
        String deviceId = message['deviceId'];
        List<dynamic> services = message['services'];
        for (var s in services) {
          onServiceDiscovered?.call(deviceId, s);
        }
      }
    } else if (message['characteristicValue'] != null) {
      String deviceId = message['deviceId'];
      var characteristicValue = message['characteristicValue'];
      String characteristic = characteristicValue['characteristic'];
      Uint8List value = Uint8List.fromList(
          characteristicValue['value']); // In case of _Uint8ArrayView
      onValueChanged?.call(deviceId, characteristic, value);
    } else if (message['mtuConfig'] != null) {
      _mtuConfigController.add(message['mtuConfig']);
    }

    return Future.value();
  }

  @override
  Future<void> setNotifiable(String deviceId, String service,
      String characteristic, BleInputProperty bleInputProperty) {
    return _channel.invokeMethod('setNotifiable', {
      'deviceId': deviceId,
      'service': service,
      'characteristic': characteristic,
      'bleInputProperty': bleInputProperty.value,
    }).then((_) => print('setNotifiable invokeMethod success'));
  }

  @override
  Future<void> writeValue(
      String deviceId,
      String service,
      String characteristic,
      Uint8List value,
      BleOutputProperty bleOutputProperty) {
    return _channel.invokeMethod('writeValue', {
      'deviceId': deviceId,
      'service': service,
      'characteristic': characteristic,
      'value': value,
      'bleOutputProperty': bleOutputProperty.value,
    }).then((_) {
      print('writeValue invokeMethod success');
    }).catchError((onError) {
      // Characteristic sometimes unavailable on Android
      throw onError;
    });
  }

  // FIXME Close
  final _mtuConfigController = StreamController<int>.broadcast();

  @override
  Future<int> requestMtu(String deviceId, int expectedMtu) async {
    _channel.invokeMethod('requestMtu', {
      'deviceId': deviceId,
      'expectedMtu': expectedMtu,
    }).then((_) => print('requestMtu invokeMethod success'));
    return await _mtuConfigController.stream.first;
  }
}
