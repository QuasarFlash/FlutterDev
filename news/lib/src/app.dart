import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stores_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: "Flutter News",
        home: NewsList(),
      ),
    );
  }
}
