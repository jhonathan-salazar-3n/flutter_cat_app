import 'dart:convert';
import 'dart:developer';

import 'package:flutter_cat_app/models/cat_app_model.dart';
import 'package:flutter_cat_app/models/common.dart';
import 'package:http/http.dart' as http;

List<CatAppModel> list = [];

Future<List<CatAppModel>> fetchCats(String? name) async {
  http.Response response = await http.get(
    Uri.parse(
      name == "" ? Common().baseUrl : "${Common().searchUrl}$name${Common().apiKey}"));

  if (response.statusCode == 200) {
    try {
      var decodeJson = jsonDecode(response.body) as List;
      list = decodeJson.map((e) => CatAppModel.fromJson(e)).toList();
    } catch (e) {
      log("message", error: e.toString());
    }
  }
  return list;
}
