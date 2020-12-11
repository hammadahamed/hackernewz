import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hackernewz/essentials.dart';
import 'package:hackernewz/tiles.dart';

// ignore: must_be_immutable
class NewsList extends StatefulWidget {
  // bool isLoading;
  @override
  State<StatefulWidget> createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  ApiCaller apiCaller = ApiCaller();
  GetUrl getUrl = GetUrl();

  var idList = [];
  var items = [];
  StreamController streamController = StreamController();

  // to retrieve the id's ....................................
  getList() async {
    idList = await apiCaller.getResponse(url: getUrl.idListUrl);
    idList = idList.toList();
    print("idList -- ");
    print(idList);
  }
//--------------------------------
  // getList() async*{

  // }
//--------------------------------
  // to retrieve the items ....................................

  getItems() async {
    var count = 0;

    for (var num in idList) {
      if (count > 10) {
        break;
      }
      var temp =
          await apiCaller.getResponse(url: getUrl.getItemUrl(num)) as Map;
      streamController.add(temp);
      print("temp--- ");
      print(temp);
      items.add(temp);
      count++;
    }
    // streamController.done;
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
    streamController.close();
    streamController.stream.listen((event) {}).cancel();
    streamController.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // this should be initialized ONLY here ,
    // bcoz the lists should again be empty whnever it rebuilds
    // widget.isLoading = true;
    // idList = [];
    // items = [];
    MyColors myColors = MyColors();

    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snap) {
        print("snap.data");
        print(snap.data);
        if ((snap.connectionState == ConnectionState.none &&
                snap.hasData == false) ||
            snap.data == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(myColors.chocoViolet),
            ),
          );
        }
        // items.add(snap.data);
        // snap.data = null;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            // print("snap.data.length --- ");
            // print(snap.data.length);
            var obj = items[index];
            return Tiles(
              buildContext: context,
              url: obj["url"],
              title: obj["title"],
              author: obj["by"].toString(),
              score: obj["score"].toString(),
            );
          },
        );
      },
    );
  }
}
