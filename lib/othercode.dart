/*
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late BluetoothConnection connection;
  List<double> dataList = [];

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {
    BluetoothDevice? device;

    List<BluetoothDevice> bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    if (bondedDevices.isNotEmpty) {
      for (BluetoothDevice dev in bondedDevices) {
        if (dev.name == "HC-05") {
          device = dev;
          break;
        }
      }
    }

    if (device != null) {
      //bluetoothconnection gelen verileri dinliyoruz.
      await BluetoothConnection.toAddress(device.address).then((_connection) {
        print('Connected to the device');

        connection = _connection;
        connection.input?.listen(_onDataReceived).onDone(() {
          print('Disconnected');
        });
      });
    } else {
      print('Device not found');
    }
  }

  void _onDataReceived(List<int> data) {
    setState(() {
      String dataString = String.fromCharCodes(data);
      List<String> dataListString = dataString.split(',');
      for (String dataStr in dataListString) {
        double newData = double.tryParse(dataStr) ?? 0;
        if (dataList.length >= 25) {
          dataList.removeAt(0);
        }
        dataList.add(newData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Data'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                'Data ${index + 1}: ${dataList[index]}',
                style: TextStyle(fontSize: 24.0),
              );
            },
          ),
        ),
      ),
    );
  }
}

 */
