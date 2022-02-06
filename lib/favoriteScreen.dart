import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'medicine.dart';

class FavoriteScreen extends StatefulWidget
{
  @override
  _FavoriteState createState() => _FavoriteState();

}

class _FavoriteState extends State<FavoriteScreen>{

  var box;
  List<Medicine> favoritelist = [];

  @override
  void initState()
  {
    super.initState();
    initBox();
  }

  void initBox() async
  {
    this.box = Hive.box('savedata');
    var data = box.get('medicine') ?? [];
    if(data.isNotEmpty){
      Iterable list = json.decode(data);
      favoritelist = list.map((e) => Medicine.fromJson(e)).toList();
      favoritelist.sort(
              (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue,
  );
}
