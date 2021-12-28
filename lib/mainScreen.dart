import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tnampet/favoriteScreen.dart';
import 'package:tnampet/homeScreen.dart';
import 'package:tnampet/infoScreen.dart';

class MainScreen extends StatefulWidget{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    HomeScreen(),
    FavoriteScreen(),
    InfoScreen(),
  ];
  final items = <Widget>[
    Icon(Icons.favorite, size: 25,),
    Icon(Icons.home, size: 25,),
    Icon(Icons.info, size: 25,),
  ];
  int index = 1;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.orange,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 200),
        height: 50,
        index: index,
        items: items,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}