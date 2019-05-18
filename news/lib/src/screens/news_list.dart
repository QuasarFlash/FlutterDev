import 'package:flutter/material.dart';
import 'package:news/src/app.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: Text("News Here"),
    );
  }
}
