import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screen/CategoryScreen.dart';
import 'Screen/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _screenIndex = 0;

  List<Widget> _screenOption = <Widget>[HomeScreen(), CategoryScreen()];

  void _onItemTap(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: HexColor("#101118"),
        body: Center(
          child: Container(
            child: _screenOption.elementAt(_screenIndex),
          ),
        ),
        bottomNavigationBar: Container(
          height: 70.0,
          child: BottomNavigationBar(
            // elevation: 80.0,
            backgroundColor: HexColor("#101118"),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 15,
            unselectedFontSize: 13,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.wallpaper,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.collections,
                ),
                label: "Collections",
              ),
            ],
            currentIndex: _screenIndex,
            onTap: _onItemTap,
          ),
        ),
      ),
    );
  }
}
