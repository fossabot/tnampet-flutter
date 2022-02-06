import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
  List<Medicine> favoritelist = [];
  var box;
  _DetailScreen(item) {
    this.item = item;
  }

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
      for (var element in favoritelist){
        if(element.id == item.id) {
          this._isfavorite = true;
          continue;
        }
      }
    }
  }

  void updateBox(var item) async
  {
    favoritelist.add(item);
    var text = json.encode(favoritelist);
    box.put('medicine', text);
  }

  void removeBox(var item) async
  {
    favoritelist.removeWhere((element) => element.title == item.title);
    var text = json.encode(favoritelist);
    box.put('medicine', text);
  }

  Widget detailContainer(
      Color color,
      IconData icon,
      String header,
      String body,
      ){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              Icon(icon,color: Colors.white,),
              Text(header,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
        SizedBox(height: 4,),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: color
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Text(body,style: TextStyle(color: color)),
        ),
        SizedBox(height: 8,),
      ],
    );
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
                    if(_isfavorite){
                      removeBox(item);
                      this._isfavorite = false;
                    }else{
                      updateBox(item);
                      this._isfavorite = true;
                    }
                    log(favoritelist.toString());
                  });
                },
                icon: Icon(
                  Icons.favorite,
                  color: (_isfavorite) ? Colors.red : Colors.black,
                ),
              ),
            ]),
            Container(
              child: Text(item.intro_content, textAlign: TextAlign.justify,),
            ),
            SizedBox(height: 16,),
            detailContainer(Colors.red, Icons.dangerous, item.side_effect, item.side_effect_content),
            detailContainer(Colors.yellow, Icons.warning, item.warning, item.warning_content),
            detailContainer(Colors.green, Icons.help, item.usage, item.usage_content)
          ]),
    );
  }
}
