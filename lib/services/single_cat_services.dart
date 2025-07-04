import 'dart:convert';
import 'dart:developer';

import 'package:flutter_cat_app/models/common.dart';
import 'package:flutter_cat_app/models/single_cat_model.dart';
import 'package:http/http.dart' as http;

List<SingleCatModel> list = [];

Future<List<SingleCatModel>> fetchCatImage(String id) async {
  http.Response response = await http.get(
    Uri.parse(
      '${Common().singleImage}$id'));

  if (response.statusCode == 200) {
    try {
      var decodeJson = jsonDecode(response.body) as List;
      list = decodeJson.map((e) => SingleCatModel.fromJson(e)).toList();
    } catch (e) {
      log("message", error: e.toString());
    }
  }
  return list;
}
