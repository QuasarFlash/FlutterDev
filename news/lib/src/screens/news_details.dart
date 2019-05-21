import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import 'dart:async';
import '../widgets/comment.dart';
import '../widgets/news_webview.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;
  const NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);
    return buildBody(bloc);
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("News Detail"),
    //   ),
    //   body: buildBody(bloc),
    // );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return buildLoading();
        }
        final itemFuture = snapshot.data[itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return buildLoading();
            }
            return buildStory(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildStory(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${item.title}'),
      ),
      body: buildStoryBody(item, itemMap),
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: Key(item.title),
        title: Text(
          item.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child:
                Column(
              children: <Widget>[
                NewsWebView(
                  newsUrl: item.url,
                  height: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStoryBody(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((commentId) {
      return Comment(
        itemId: commentId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildLoading() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Story'),
      ),
      body: Container(
          alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
