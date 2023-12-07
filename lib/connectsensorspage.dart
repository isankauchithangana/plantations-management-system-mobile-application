import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'sensors.dart';

class ConnectSensorsPage extends StatefulWidget {
  @override
  _ConnectSensorsPageState createState() => _ConnectSensorsPageState();
}

class _ConnectSensorsPageState extends State<ConnectSensorsPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? connectedDevice;
  String connectionStatus = '';

  @override
  void initState() {
    super.initState();
    _startScanning();
  }

  void _startScanning() {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    flutterBlue.scanResults.listen((List<ScanResult> scanResults) {
      for (ScanResult result in scanResults) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });
  }

  
    );
  }
}
