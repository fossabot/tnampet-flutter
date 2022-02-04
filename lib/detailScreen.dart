import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  var detail;

  DetailScreen(item) {
    this.detail = item;
  }

  @override
  _DetailScreen createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.orange,
        title: Text("ព័ត៍មានលំអិត",textAlign: TextAlign.center, )
      )
    );
  }
}
