import 'dart:async';

import 'package:flutter/material.dart';

import 'mainScreen.dart';

class SplashScreen extends StatefulWidget
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/logo.png',height: 150,),
            SizedBox(height: 10,),
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),)
          ],
        ),
      ),

    );
  }
}