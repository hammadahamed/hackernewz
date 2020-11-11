import 'package:flutter/material.dart';
import 'package:hackernewz/newslist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackernewz/essentials.dart';

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
  MyColors myColors = MyColors();
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myColors.matteBlackBg,
          centerTitle: true,
          title: Text("HACKER NEWS  ",
              style: GoogleFonts.baloo(
                  fontSize: 29,
                  color: Colors.white,
                  fontWeight: FontWeight.w100)),
        ),
        backgroundColor: myColors.matteBlackBg,
        body: Container(
          height: MediaQuery.of(context).size.height - 80,
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 25),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color(0xff8c3f8e),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Top  10  Stories",
                          style: GoogleFonts.staatliches(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height - 150
                    : MediaQuery.of(context).size.height - 150,
                child: NewsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
