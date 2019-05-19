import 'package:flutter/material.dart';


class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
          trailing: buildContainer(ht: 20.0, wt: 20.0),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildContainer({ht:24.0, wt:150.0}) {

    return Container(
      color:Colors.grey[200],
      height: ht,
      width: wt,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}