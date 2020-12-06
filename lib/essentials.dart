import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyColors {
  Color _matteBlackBg = Color(0xff2b2b2b);
  Color mattegreyFg = Color(0xff3f3f3f);
  Color chocoViolet = Color(0xff8c3f8e);
  Color darkWhite = Colors.white70;

  get matteBlackBg => _matteBlackBg;
}

// to call the apis
class ApiCaller {
  var list;

  Future<dynamic> getResponse({url}) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      list = jsonDecode(response.body);
    } else
      throw Exception("error in custom api caller method");
    return list;
  }
}

// to return web request URL ,because there are lots of url to interact to

class GetUrl {
  String idListUrl = "https://hacker-news.firebaseio.com/v0/topstories.json";

  String getItemUrl(id) {
    String url =
        "https://hacker-news.firebaseio.com/v0/item/" + id.toString() + ".json";

    return url;
  }
}
