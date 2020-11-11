import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  var list;

  Future<dynamic> getRsponse({url}) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      list = jsonDecode(response.body);
    } else
      throw Exception("error in custom api caller method");
    return list;
  }
}

class GetUrl {
  String idListUrl = "https://hacker-news.firebaseio.com/v0/topstories.json";

  String getItemUrl(id) {
    String url =
        "https://hacker-news.firebaseio.com/v0/item/" + id.toString() + ".json";

    return url;
  }
}
