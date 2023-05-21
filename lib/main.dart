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

  // Listen to data on the connection
  void _onDataReceived(List<int> data) {
    setState(() {
      String dataString = String.fromCharCodes(data);
      List<String> dataListString = dataString.split(',');
      for (int i = 0; i < dataListString.length; i++) {
        double dataValue = double.tryParse(dataListString[i]) ?? 0;
        if (dataList.length > i) {
          if (dataList.length == 25) {
            dataList.removeAt(0);
          }
          dataList[i] = dataValue;
        } else {
          dataList.add(dataValue);
        }
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    List<Widget> textWidgets = [];

    for (int i = 0; i < 25; i++) {
      String text = (dataList.length > i) ? dataList[i].toString() : '';
      textWidgets.add(Text(
        'Data ${i + 1}: $text',
        style: TextStyle(fontSize: 18.0),
      ));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Data'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textWidgets,
          ),
        ),
      ),
    );
  }
}

 */
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
  List<BluetoothDevice> availableDevices = [];

  // Listen to data on the connection
  void _onDataReceived(List<int> data) {
    setState(() {
      String dataString = String.fromCharCodes(data);
      List<String> dataListString = dataString.split(',');
      for (int i = 0; i < dataListString.length; i++) {
        double dataValue = double.tryParse(dataListString[i]) ?? 0;
        if (dataList.length > i) {
          if (dataList.length == 25) {
            dataList.removeAt(0);
          }
          dataList[i] = dataValue;
        } else {
          dataList.add(dataValue);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getBondedDevices();
  }

  void _getBondedDevices() async {
    List<BluetoothDevice> bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      availableDevices = bondedDevices;
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    if (device != null) {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> textWidgets = [];

    for (int i = 0; i < 25; i++) {
      String text = (dataList.length > i) ? dataList[i].toString() : '';
      textWidgets.add(Text(
        'Data ${i + 1}: $text',
        style: TextStyle(fontSize: 18.0),
      ));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Data'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: null,
                items: availableDevices.map((device) {
                  return DropdownMenuItem(
                    value: device,
                    child: Text(device.name.toString()),
                  );
                }).toList(),
                onChanged: (device) {
                  _connectToDevice(device as BluetoothDevice);
                },
              ),
              SizedBox(height: 20.0),
              Column(
                children: textWidgets,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
