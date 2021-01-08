import 'dart:convert';
import 'package:http/http.dart' as http;

import 'mainmain.dart';

void main() async {
  String url = "https://barcode.monster/api/";
  //var barcode = HomePageState().getBarCode();
  // var barcode = HomePageState()._barcode;
  // final response = await http.get(url + barcode);
}

class GetData {
  String code;
  String description;

  GetData({this.code, this.description});

  GetData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}
