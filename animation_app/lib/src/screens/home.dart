import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  final Widget child;

  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catControl;

  Animation<double> boxAnimation;
  AnimationController boxControl;
  static const Curve shakeBox = _ShakeCurve._();

  @override
  void initState() {
    super.initState();

    catControl = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(
      begin: -40.0,
      end: -83.0,
    ).animate(
      CurvedAnimation(
        parent: catControl,
        curve: Curves.easeIn,
      ),
    );

    boxControl = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxControl,
        curve: Curves.easeInOut,
        // curve: shakeBox,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxControl.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxControl.forward();
      }
    });
    boxControl.forward();
  }

  onTap() {
    if (catControl.status == AnimationStatus.completed) {
      catControl.reverse();
      boxControl.forward();

    } else if (catControl.status == AnimationStatus.dismissed) {
      catControl.forward();
      boxControl.stop();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            // alignment: AlignmentDirectional.center,
            children: <Widget>[
              buildCatAnimation(),
              buildLeftFlap(),
              buildRightFlap(),
              buildBox(),
              // boxShakeFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (BuildContext context, Widget child) {
        return Positioned(
          child: child,
          // width: 200.0,
          right: 0.0,
          left: 0.0,
          top: catAnimation.value,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }
  
  // TODO: Try to make box shake also
   Widget boxShakeFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: buildBox(),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: 0,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      top: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
          );
        },
      ),
    );
  }
  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      top: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            child: child,
            angle: -boxAnimation.value,
            alignment: Alignment.topRight,
          );
        },
      ),
    );
  }
}
class _ShakeCurve extends Curve {
  const _ShakeCurve._();
  @override
  double transform(double t) => sin(t * pi * 2);
}