/*
import 'package:flutter/material.dart';

class BluetoothDataScreen extends StatefulWidget {
  final String data;

  BluetoothDataScreen({required this.data});

  @override
  _BluetoothDataScreenState createState() => _BluetoothDataScreenState();
}

class _BluetoothDataScreenState extends State<BluetoothDataScreen> {
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();

    // Verileri virgülle ayırarak dizi haline getir
    dataList = widget.data.split(",");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Data"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Data ${index + 1}"),
              subtitle: Text("${dataList[index]}"),
            );
          },
        ),
      ),
    );
  }
}



 */
