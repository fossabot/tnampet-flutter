import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tnampet/favoriteScreen.dart';
import 'package:tnampet/homeScreen.dart';
import 'package:tnampet/infoScreen.dart';
import 'package:tnampet/medicine.dart';

class MainScreen extends StatefulWidget{
  var medicinelist;

  MainScreen(List<Medicine> medicinelist){
    this.medicinelist = medicinelist;
  }
  @override
  _MainPageState createState() => _MainPageState(medicinelist);
}

class _MainPageState extends State<MainScreen> {

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  var favoriteScreen = FavoriteScreen();
  var homeScreen = null;
  var infoScreen = InfoScreen();
  var screens = [];
  _MainPageState(List<Medicine> medicinelist)
  {
    this.homeScreen = HomeScreen(medicinelist);
    screens = [
      favoriteScreen,
      homeScreen,
      infoScreen,
    ];
  }

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
      appBar: AppBar(
        title: Text("ថ្នាំពេទ្យ"),
        backgroundColor: Colors.orange,
      ),
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Colors.orange,
        backgroundColor: Color(0xCCC).withOpacity(0.07),
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