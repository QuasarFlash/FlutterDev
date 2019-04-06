import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';
import 'screens/pageOne.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Log Me In',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Log Me In'),
          ),
          body: PageOne(
              // child:,//LoginScreen(),
              ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.view_headline),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_headline),
                title: Text("Page 1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
