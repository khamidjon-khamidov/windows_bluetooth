import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
// import 'package:quick_blue/quick_blue.dart';

const String WOODEMI_SUFFIX = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

const String WOODEMI_SERV__COMMAND = '57444d01-$WOODEMI_SUFFIX';
const String WOODEMI_CHAR__COMMAND_REQUEST = '57444e02-$WOODEMI_SUFFIX';
const String WOODEMI_CHAR__COMMAND_RESPONSE = WOODEMI_CHAR__COMMAND_REQUEST;

const WOODEMI_MTU_WUART = 247;

class PeripheralDetailPage extends StatefulWidget {
  final String deviceId;

  const PeripheralDetailPage(this.deviceId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PeripheralDetailPageState();
  }
}

class _PeripheralDetailPageState extends State<PeripheralDetailPage> {
  @override
  void initState() {
    super.initState();
    // todo
    // QuickBlue.setConnectionHandler(_handleConnectionChange);
    // QuickBlue.setServiceHandler(_handleServiceDiscovery);
    // QuickBlue.setValueHandler(_handleValueChange);
  }

  @override
  void dispose() {
    super.dispose();
    // todo
    // QuickBlue.setValueHandler(null);
    // QuickBlue.setServiceHandler(null);
    // QuickBlue.setConnectionHandler(null);
  }

  // todo
  // void _handleConnectionChange(String deviceId, BlueConnectionState state) {
  //   print('_handleConnectionChange $deviceId, $state');
  // }

  void _handleServiceDiscovery(String deviceId, String serviceId) {
    print('_handleServiceDiscovery $deviceId, $serviceId');
  }

  // todo
  // void _handleValueChange(
  //     String deviceId, String characteristicId, Uint8List value) {
  //   print(
  //       '_handleValueChange $deviceId, $characteristicId, ${hex.encode(value)}');
  // }

  final serviceUUID = TextEditingController(text: WOODEMI_SERV__COMMAND);
  final characteristicUUID =
      TextEditingController(text: WOODEMI_CHAR__COMMAND_REQUEST);
  final binaryCode = TextEditingController(
      text: hex.encode([0x01, 0x0A, 0x00, 0x00, 0x00, 0x01]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeripheralDetailPage'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: const Text('connect'),
                onPressed: () {
                  // QuickBlue.connect(widget.deviceId);
                },
              ),
              ElevatedButton(
                child: const Text('disconnect'),
                onPressed: () {
                  // todo
                  // QuickBlue.disconnect(widget.deviceId);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: const Text('discoverServices'),
                onPressed: () {
                  // todo
                  // QuickBlue.discoverServices(widget.deviceId);
                },
              ),
            ],
          ),
          ElevatedButton(
            child: const Text('setNotifiable'),
            onPressed: () {
              // todo
              // QuickBlue.setNotifiable(widget.deviceId, WOODEMI_SERV__COMMAND,
              //     WOODEMI_CHAR__COMMAND_RESPONSE, BleInputProperty.indication);
            },
          ),
          TextField(
            controller: serviceUUID,
            decoration: const InputDecoration(
              labelText: 'ServiceUUID',
            ),
          ),
          TextField(
            controller: characteristicUUID,
            decoration: const InputDecoration(
              labelText: 'CharacteristicUUID',
            ),
          ),
          TextField(
            controller: binaryCode,
            decoration: const InputDecoration(
              labelText: 'Binary code',
            ),
          ),
          ElevatedButton(
            child: const Text('send'),
            onPressed: () {
              // todo
              // var value = Uint8List.fromList(hex.decode(binaryCode.text));
              // QuickBlue.writeValue(
              //     widget.deviceId,
              //     serviceUUID.text,
              //     characteristicUUID.text,
              //     value,
              //     BleOutputProperty.withResponse);
            },
          ),
          ElevatedButton(
            child: const Text('requestMtu'),
            onPressed: () async {
              // todo
              // var mtu = await QuickBlue.requestMtu(
              //     widget.deviceId, WOODEMI_MTU_WUART);
              // print('requestMtu $mtu');
            },
          ),
        ],
      ),
    );
  }
}
