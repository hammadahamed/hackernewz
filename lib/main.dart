import 'package:flutter/material.dart';
import 'package:hackernewz/newslist.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hackernewz/newslist2.dart';

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
        backgroundColor: Color(0xff2b2b2b),
        centerTitle: true,
        title: Text(
          "HACKER NEWS  ",
          style: GoogleFonts.righteous(fontSize: 29, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xff2b2b2b),
      body: Container(
        height: MediaQuery.of(context).size.height - 200,
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
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20))),
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: NewsList(),
            ),
          ],
        ),
      ),
    );
  }
}
