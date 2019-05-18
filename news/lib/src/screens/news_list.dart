import 'package:flutter/material.dart';
import 'package:news/src/app.dart';
import 'dart:async';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
        itemCount: 10000,
        itemBuilder: (context, int index) {
          return FutureBuilder(
            future: getFuture(),
            builder: (context, snapshot) {
              return Container(
                height: 80.0,
                child: snapshot.hasData
                    ? Text('Im here $index')
                    : Text('Not here'),
              );
            },
          );
        });
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => "Hi",
    );
  }
}
