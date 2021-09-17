import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:quick_blue/quick_blue.dart';
import 'package:windows_bluetooth_example/peripheral_device_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late StreamSubscription<BlueScanResult> _subscription;

  @override
  void initState() {
    super.initState();
    // _subscription = QuickBlue.scanResultStream.listen((result) {
    //   if (!_scanResults.any((r) => r.deviceId == result.deviceId)) {
    //     setState(() => _scanResults.add(result));
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future:
                  Future.value(false), // todo QuickBlue.isBluetoothAvailable(),
              builder: (context, snapshot) {
                var available = snapshot.data?.toString() ?? '...';
                return Text('Bluetooth init: $available');
              },
            ),
            _buildButtons(),
            const Divider(
              color: Colors.blue,
            ),
            _buildListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          child: const Text('startScan'),
          onPressed: () {
            // todo QuickBlue.startScan();
          },
        ),
        ElevatedButton(
          child: const Text('stopScan'),
          onPressed: () {
            // QuickBlue.stopScan();
          },
        ),
      ],
    );
  }

  var _scanResults = []; // todo List<BlueScanResult>();

  Widget _buildListView() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          title:
              Text('${_scanResults[index].name}(${_scanResults[index].rssi})'),
          subtitle: Text(_scanResults[index].deviceId),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PeripheralDetailPage(_scanResults[index].deviceId),
                ));
          },
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _scanResults.length,
      ),
    );
  }
}
