import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hackernewz/essentials.dart';
import 'package:http/http.dart' as http;
import 'package:hackernewz/tiles.dart';
// import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NewsList extends StatefulWidget {
  bool isLoading;
  @override
  State<StatefulWidget> createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  ApiCaller caller = ApiCaller();
  GetUrl getUrl = GetUrl();

  var idList;
  var items;
  StreamController itemStream = StreamController();

  // to retrieve the id's ....................................
  getList() async {
    idList = await caller.getRsponse(url: getUrl.idListUrl);
    idList = idList.toList();
  }

  // to retrieve the items ....................................

  getItems() async {
    var count = 0;

    for (var num in idList) {
      if (count > 10) {
        break;
      }

      var res = await http.get(getUrl.getItemUrl(num));

      if (res.statusCode == 200) {
        var temp = jsonDecode(res.body) as Map;
        // print(temp);
        // items.add(temp);
        itemStream.add(temp);
        // yield temp;
      } else {
        print("error");
      }
      count++;
      // print(res.statusCode);
    }
    itemStream.done;
    // return items;
  }

  //----------------------------------------------------------------------------
  @override
  void initState() {
    getList().then((_) => getItems());
    super.initState();
  }

  @override
  void dispose() {
    //todo
    itemStream.close();
    itemStream.stream.listen((event) {}).cancel();
    itemStream.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this should be initialized ONLY here ,
    // bcoz the lists should again be empty whnever it rebuilds
    widget.isLoading = true;
    idList = [];
    items = [];
    return StreamBuilder(
        stream: itemStream.stream,
        builder: (context, snap) {
          if ((snap.connectionState == ConnectionState.none &&
                  snap.hasData == false) ||
              snap.data == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xff8c3f8e)),
              ),
            );
          }
          items.add(snap.data);

          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                var obj = items[index];
                return Tiles(
                  title: obj["title"],
                  author: obj["by"].toString(),
                  score: obj["score"].toString(),
                );
              });
        });
  }
}
