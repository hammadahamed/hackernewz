import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NewsList extends StatefulWidget {
  bool isLoading = true;
  // final List items = [];
  @override
  State<StatefulWidget> createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  var itemNum;
  var items = [];

  // to retrieve the id's ....................................
  Future getList() async {
    print("get list started ---------------------");
    String host = "https://hacker-news.firebaseio.com/v0/topstories.json";
    var response = await http.get(host);

    if (response.statusCode == 200) {
      // retrieving and parsing top stories list
      itemNum = jsonDecode(response.body) as List;
      print(itemNum.runtimeType);

      return itemNum;
    } else {
      throw Exception("Failed to Load items");
    }
  }

  // to retrieve the items ..............................

  Future getItems() async {
    print("getitems started ---------------------" + itemNum.length.toString());
    var count = 1;
    for (var num in itemNum) {
      print("insisde for loop");
      if (count > 10) {
        print("break");
        break;
      }
      var url = "https://hacker-news.firebaseio.com/v0/item/" +
          num.toString() +
          ".json";
      var res = await http.get(url);

      if (res.statusCode == 200) {
        var temp = jsonDecode(res.body) as Map;
        print(temp);
        // items.add(temp);
        print("cheakpoint");

        items.add(temp);
      } else {
        print("error");
      }
      count++;
      print(res.statusCode);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2));
    return Expanded(
      child: FutureBuilder(
          future: getList().then((value) => getItems()),
          builder: (context, snap) {
            if ((snap.connectionState == ConnectionState.none &&
                    snap.hasData == false) ||
                snap.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.cyan),
                ),
              );
            }

            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (BuildContext context, int index) {
                  print(snap.data);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Colors.grey, width: 5)),
                            // color: Colors.red,
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white60,
                                  offset: Offset(0, 6),
                                  blurRadius: 1),
                            ]),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          title: Text(
                            snap.data[index]["title"],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          subtitle:
                              Text("\n-" + snap.data[index]["by"].toString()),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.cyan,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                snap.data[index]["score"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          // isThreeLine: true,
                        )),
                  );
                });
          }),
    );
  }
}
