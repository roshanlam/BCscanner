import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String _url = "https://barcode.monster/api/";
  String message = "Scan Gar ra ja, mero aro cam cha ";
  String _barcode = " ";

  @override
  void initState() {
    super.initState();
    getinfo();
  }

  Future<void> barcodeScan() async {
    String _barcodeScan = '';
    try {
      _barcodeScan = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.BARCODE);
      print(barcodeScan);
    } on PlatformException {
      _barcodeScan = 'Failed To Get Platform Version';
    }
    String url = _url + _barcodeScan;
    final response = await http.get(url);
    GetData getData = GetData.fromJson(jsonDecode(response.body));
    var desc = getData.description;

    if (!mounted) return;
    setState(() {
      _barcode = desc;
    });
  }

  void getinfo() async {
    String _url = "https://barcode.monster/api/";
    String url = _url + _barcode;
    final response = await http.get(url);
    print(response.body);
    GetData getData = GetData.fromJson(jsonDecode(response.body));
    String desc = getData.description;
    print(desc);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ScanGar"),
      ),
      body: Center(
        child: Text(
          '$message ' + '\n\n$_barcode',
          style: new TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera),
        label: Text("Scan Gar Chito"),
        onPressed: () => barcodeScan(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class GetData {
  String description;
  GetData({this.description});
  GetData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
