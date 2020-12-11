import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackernewz/essentials.dart';
import 'package:hackernewz/webview.dart';

class Tiles extends StatelessWidget {
  final title, author, score, url, buildContext;

  Tiles({this.title, this.author, this.score, this.url, this.buildContext});

  @override
  Widget build(BuildContext buildContext) {
    MyColors myColors = MyColors();

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20, top: 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: myColors.mattegreyFg,
          ),
          child: ListTile(
            onTap: () {
              print("url----");
              print(url.runtimeType);
              return showDialog(
                context: buildContext,
                builder: (context) => WebViewPg(url: url),
              );
            },
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            title: Text(
              title,
              style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "author - " + author,
                style: TextStyle(color: myColors.darkWhite),
              ),
            ),
            trailing: CircleAvatar(
              backgroundColor: myColors.chocoViolet,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  score,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white),
                ),
              ),
            ),
          )),
    );
  }
}
