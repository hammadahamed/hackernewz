import 'package:flutter/material.dart';
import 'package:hackernewz/newslist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackernewz/newslist2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackers News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.red[900],
        // accentColor: Colors.grey[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "HACKER NEWS  ",
          style: GoogleFonts.righteous(fontSize: 29, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              width: 150,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20))),
                // color: Colors.cyan,
                child: Center(
                  child: Text(
                    "Top 10 Stories",
                    style: GoogleFonts.staatliches(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          NewsList(),
        ],
      ),
    );
  }
}
