import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'detailScreen.dart';
import 'medicine.dart';

class FavoriteScreen extends StatefulWidget
{
  @override
  _FavoriteState createState() => _FavoriteState();

}

class _FavoriteState extends State<FavoriteScreen>{

  var box;
  List<Medicine> favoritelist = [];
  var items;
  var item;

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
      items = favoritelist;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items.elementAt(index).title}'),
          onTap: () {
            setState(() {
              this.item = items.elementAt(index);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailScreen(item))).then((value) => setState(() {

              }));
            });
          },
        );
      },
      separatorBuilder: (context, index) => Divider(),
    ),
  );
}
