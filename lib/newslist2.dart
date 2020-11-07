import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class NewsList2 extends StatefulWidget {
  bool isLoading = true;
  // final List items = [];
  @override
  State<StatefulWidget> createState() => NewsList2State();
}

class NewsList2State extends State<NewsList2> {
  // var items = [];
  var itemNum;

  void getList() async {
    String host = "https://hacker-news.firebaseio.com/v0/topstories.json";
    var response = await http.get(host);

    if (response.statusCode == 200) {
      // retrieving and parsing top stories list
      itemNum = jsonDecode(response.body) as List;
      print(itemNum.runtimeType);

      setState(() {
        widget.isLoading = false;
      });
    } else {
      throw Exception("Failed to Load items");
    }
  }

  Future getItems() async {
    var items;
    var count = 1;
    for (var num in itemNum) {
      if (count > 10) {
        break;
      }
      var url = "https://hacker-news.firebaseio.com/v0/item/" +
          num.toString() +
          ".json?print=pretty";
      var res = await http.get(url);
      if (res.statusCode == 200) {
        var temp = jsonDecode(res.body) as Map;
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
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getList();
    return Expanded(
      child: ListView.builder(
        itemCount: itemNum.length,
        itemBuilder: (context, index) {
          return widget.isLoading
              ? CircularProgressIndicator()
              : FutureBuilder(
                  future: getItems(),
                  builder: (context, snap) {
                    if ((snap.connectionState == ConnectionState.none ||
                            snap.data == null) ||
                        snap.hasData == false) {
                      return CircularProgressIndicator();
                    }
                    //---------------------------------------------------------------

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  left:
                                      BorderSide(color: Colors.grey, width: 5)),
                              // color: Colors.red,
                              // borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white60,
                                    offset: Offset(0, 6),
                                    blurRadius: 1),
                              ]),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
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

                    //---------------------------------------------------------------
                    // return Container();
                  },
                );
        },
      ),
    );
  }
}
