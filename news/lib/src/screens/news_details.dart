import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import 'dart:async';

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
            return buildTitle(itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${item.title}'),
      ),
      body: buildStoryBody(item),
    );
  }

  Widget buildStoryBody(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize:  20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget buildLoading(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Story'),
      ),
      body:  Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator()),
    );
  }
}
