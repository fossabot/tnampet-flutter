import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
        saveBox();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen(medicinelist)));
      });
    });
  }

  void checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Fluttertoast.showToast(
            msg: "Has internet connection!", backgroundColor: Colors.grey);
      getMedicinefromAPI();
    } else {
      initBox();
    }
  }

  void initBox() async {
    Box box = Hive.box('savedata');
    var data = box.get('LoadMedicine') ?? [];
    if (data.isNotEmpty) {
      Iterable list = json.decode(data);
      medicinelist = list.map((e) => Medicine.fromJson(e)).toList();
      medicinelist.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
      Fluttertoast.showToast(
          msg: "No internet connection!", backgroundColor: Colors.grey);
      await Future.delayed(Duration(seconds: 2)).then((value) =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MainScreen(medicinelist))));
    } else {
      Fluttertoast.showToast(
          msg:
              "Network error or No data available.\n Please connect internet try again.",
          backgroundColor: Colors.grey);
      await Future.delayed(Duration(seconds: 3)).then((value) => exit(0));
    }
  }

  void saveBox() async {
    Box box = Hive.box('savedata');
    var text = json.encode(medicinelist);
    box.put('LoadMedicine', text);
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
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
