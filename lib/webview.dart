import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackernewz/essentials.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPg extends StatefulWidget {
  final String url;
  WebViewPg({this.url});
  @override
  _WebViewPgState createState() => _WebViewPgState();
}

class _WebViewPgState extends State<WebViewPg> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print("url------" + widget.url);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Material(
            color: MyColors().matteBlackBg,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors().mattegreyFg,
                // borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: EdgeInsets.all(2),
              height: MediaQuery.of(context).size.height - 200,
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ),
        RaisedButton(
          color: MyColors().chocoViolet,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
