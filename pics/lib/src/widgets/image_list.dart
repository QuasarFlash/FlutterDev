import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget{
  final List<ImageModel> images;
  var cardsOn = false;
  ImageList(this.images);
  ImageList.cards(this.images){
    cardsOn = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, int index){
          return cardsOn ? MyCard(images[index]): buildImage(images[index]);
        },
      ),
    );
  }

  Widget buildImage(ImageModel image){
    return Container(
            decoration: BoxDecoration(
              border:Border.all(color: Colors.grey ),
            ),
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network(image.url),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Text('${image.title}'),
              ],
            ),
          );
  }
}

class MyCard extends StatelessWidget {
  //adding constructor
  // MyCard({this.title, this.icon});
  MyCard(ImageModel image){
    title = Text(image.title);
    icon = Image.network(image.url);
  }
  Widget title;
  Widget icon;

  @override
  Widget build(BuildContext context){
    return new Container(
      //adding bottom padding on card
      padding: new EdgeInsets.only(bottom: 5.0),
      child: new Card(
        child: new Container(
          //adding padding inside card
          padding: new EdgeInsets.all(15.0),
          child: new Column(
          children: <Widget>[
              this.icon,
              this.title,
            ]
          )
        )
      )
    );
  }
}