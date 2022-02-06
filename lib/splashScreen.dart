import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'mainScreen.dart';
import 'medicine.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Medicine> medicinelist = [];

  void getMedicinefromAPI() async {
    MedicineAPI.getMedicines().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        medicinelist = list.map((e) => Medicine.fromJson(e)).toList();
        medicinelist.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen(medicinelist)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getMedicinefromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            )
          ],
        ),
      ),
    );
  }
}
