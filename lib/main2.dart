import 'dart:convert';
import 'package:http/http.dart';
import 'main.dart';

class ApiGet {
  final String _url = 'https://barcode.monster/api/';
  Future<List<JsonData>> flutterRespositoriesUsingAsyncAwait() async {
    Response response = await get(_url);
    List<dynamic> parsed = json.decode(response.body);
    return parsed.map((json) => JsonData.fromJson(json)).toList();
  }

  Future<List<JsonData>> flutterRespositoriesUsingFuture() {
    return get(_url).then((response) => json.decode(response.body)).then(
        (parsed) => parsed.map((json) => JsonData.fromJson(json)).toList());
  }
}

class JsonData {
  final String desc;
  JsonData({
    this.desc,
  });

  factory JsonData.fromJson(Map<String, dynamic> json) {
    return JsonData(
      desc: json['desciption'] as String,
    );
  }

  @override
  String toString() {
    return 'The Product is $desc';
  }
}
