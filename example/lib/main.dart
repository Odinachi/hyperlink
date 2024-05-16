import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Link Rich Text Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: HyperLink(
            linkCallBack: (link) {
              //Do whatsoever with the link
            },
            textStyle: const TextStyle(color: Colors.black, fontSize: 15),
            linkStyle: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.w700, fontSize: 20),
            text:
                'Click here to visit [Google](https://www.google.com) or Click here to visit [Apple](https://www.apple.com)\t Happy Coding!!',
          ),
        ),
      ),
    ),
  ));
}
