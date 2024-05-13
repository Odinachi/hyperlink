import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Link Rich Text Example'),
      ),
      body: const Center(
        child: HyperLink(
          textStyle: TextStyle(color: Colors.black),
          linkStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
          text:
              'Click here to visit (Google)[https://www.google.com] or Click here to visit (Apple)[https://www.apple.com]',
        ),
      ),
    ),
  ));
}
