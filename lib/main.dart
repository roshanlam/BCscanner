import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  String message = "Scan Gar ra ja, mero aro cam cha ";
  String _barcode = " ";
  @override
  void initState(){
    super.initState();
  }
  Future<void> barcodeScan() async{
    String barcodeScan = '';
    try{
      barcodeScan = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.BARCODE);
      print(barcodeScan);
    }on PlatformException{
      barcodeScan = 'Failed To Get Platform Version';
    }
    if(!mounted) return;
    setState(() {
      _barcode = barcodeScan;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("ScanGar"),
      ),
      body: Center(
        child: Text(
          // message,
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