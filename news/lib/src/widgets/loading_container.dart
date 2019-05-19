import 'package:flutter/material.dart';


class LoadingContainer extends StatelessWidget {
  final bool trail;
  const LoadingContainer({Key key, this.trail=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
          trailing: this.trail ? buildContainer(ht: 20.0, wt: 20.0) : null,
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