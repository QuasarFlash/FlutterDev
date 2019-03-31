// Import flutter helper library
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

// Create a class that will be our custom Widge This class must extend the StatelessWidget base class
class AppState extends State<App> {
  int counter = 0;
  bool _cardsOnOff = false;
  List<ImageModel> images = [];

  void _incrementCounter() {
    setState(() {
      counter += 1;
    });
  }

  void _jsonDecoder() async {
    // _incrementCounter();
    counter++;
    final response =
        await get('http://jsonplaceholder.typicode.com/photos/$counter');

    // var rawJson = '{"url":"http://blah.jpeg", "id": 1}';
    var parsedJson = json.decode(response.body);
    var imageModel = new ImageModel.fromJson(parsedJson);
    
    setState(() {
      images.add(imageModel);
    });
    // print(imageModel.url);
    // _incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _cardsOnOff ?ImageList.cards(images):ImageList(images),
        appBar: AppBar(
          title: Text("Pics"),
          actions: <Widget>[
            Switch(
              onChanged: (bool value) {
                setState(() {
                  _cardsOnOff = value;
                });
              }, 
              value: _cardsOnOff,
              activeColor: Colors.black,)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _jsonDecoder,
        ),
      ),
    );
  }
}
