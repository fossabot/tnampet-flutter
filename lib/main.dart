
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tnampet/splashScreen.dart';

void  main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // TODO: implement build
    return MaterialApp(
      home: SplashScreen(),
    );
  }}