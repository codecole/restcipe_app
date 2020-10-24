import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;


  RecipeView({this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  String finalUrl;
  @override
  void initState(){
    if(widget.postUrl.contains("http://")){
      finalUrl = widget.postUrl.replaceAll("http://", "https://");

    }else{
      finalUrl = widget.postUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 60.0, bottom: 60.0, left: 24.0, right: 24.0),
                  child: Center(
                      child: Row(
                        mainAxisAlignment:
                        kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rest',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Cipe',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.postUrl,
                  onWebViewCreated: (WebViewController webViewController){
                    setState(() {
                      _controller.complete((webViewController));
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
