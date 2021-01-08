import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
// import 'api.dart';

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
    if (!mounted) return;
    setState(() {
      _barcode = _barcodeScan;
    });
    getinfo();
    // return barcodeScan;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("ScanGar"),
      ),
      body: Center(
        child: Text(
          _barcode,
          style: new TextStyle(fontSize: 30),
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
