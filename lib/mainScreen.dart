import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tnampet/favoriteScreen.dart';
import 'package:tnampet/homeScreen.dart';
import 'package:tnampet/infoScreen.dart';
import 'package:tnampet/medicine.dart';

class MainScreen extends StatefulWidget {
  var medicinelist;

  MainScreen(List<Medicine> medicinelist) {
    this.medicinelist = medicinelist;
  }
  @override
  _MainPageState createState() => _MainPageState(medicinelist);
}

class _MainPageState extends State<MainScreen> {
  var screens = [];
  int navigationIndex = 1;
  var medicinelist;
  PageController pageController =
      PageController(initialPage: 1, keepPage: true);
  final items = <Widget>[
    Icon(
      Icons.favorite,
      size: 25,
    ),
    Icon(
      Icons.home,
      size: 25,
    ),
    Icon(
      Icons.info,
      size: 25,
    ),
  ];
  _MainPageState(List<Medicine> medicinelist) {
    this.medicinelist = medicinelist;
    screens = [
      FavoriteScreen(),
      HomeScreen(medicinelist, pageController),
      InfoScreen(),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("ថ្នាំពេទ្យ"),
        backgroundColor: Colors.orange,
      ),
      body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              navigationIndex = index;
            });
          },
          children: screens.cast()),
      bottomNavigationBar: CurvedNavigationBar(  
        buttonBackgroundColor: Colors.orange,
        backgroundColor: Color(0xCCC).withOpacity(0.07),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        height: 50,
        index: navigationIndex,
        items: items,
        onTap: (index) => setState(() {
          this.navigationIndex = index;
          pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        }),
      ),
    );
  }
}
