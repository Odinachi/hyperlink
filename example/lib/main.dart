import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Link Rich Text Example'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: HyperLink(
            textStyle: TextStyle(color: Colors.black, fontSize: 15),
            linkStyle: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w700, fontSize: 20),
            text:
                'Click here to visit [Google](https://www.google.com) or Click here to visit [Apple](https://www.apple.com)\t Happy Coding!!',
          ),
        ),
      ),
    ),
  ));
}
