import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  final PageController pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: <Widget>[
        _buildPage(index: 1, color: Colors.green),
        _buildPage(index: 2, color: Colors.pink),
        _buildPage(index: 3, color: Colors.grey),
      ],
    );
  }

  Widget _buildPage({int index, Color color}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.red,
            Colors.blue,
            // Colors.indigo[600],
            // Colors.indigo[400],
          ],
        ),
      ),
      alignment: AlignmentDirectional.center,
      child: Center(
        child: Text(
          'Page $index',
          style: TextStyle(
            fontSize: 45.0,
          ),
        ),
      ),
    );
  }
}
