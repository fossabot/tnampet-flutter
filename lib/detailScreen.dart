import 'package:flutter/material.dart';

import 'medicine.dart';

class DetailScreen extends StatefulWidget {
  var item;

  DetailScreen(Medicine item) {
    this.item = item;
  }

  @override
  _DetailScreen createState() => _DetailScreen(item);
}

class _DetailScreen extends State<DetailScreen> {
  var item;
  var _isfavorite = false;
  _DetailScreen(item) {
    this.item = item;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "ព័ត៍មានលំអិត",
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(8),
          children: [
            Row(children: [
              Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'JetBrainsMono',
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    this._isfavorite = (_isfavorite) ? false : true;
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: (_isfavorite) ? Colors.red : Colors.black,
                ),
              ),
            ]),
          ]),
    );
  }
}
