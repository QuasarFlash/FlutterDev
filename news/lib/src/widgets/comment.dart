import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;
  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer(trail: false,);
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: item.text == ""
                ? Text('Comment Deleted')
                : Html(
                    data: (item.text),
                    onLinkTap: (url) {
                      print(url);
                    },
                  ),
            subtitle: item.by == "" ? Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider(
            color: Colors.blue,
          ),
        ];
        item.kids.forEach((commentId) {
          children.add(
            Comment(
              itemId: commentId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });
        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
    .replaceAll('&#x27', "'")
    .replaceAll('<p>', '\n\n')
    .replaceAll('<>/p', '');
    return Text(text);
  }
}
