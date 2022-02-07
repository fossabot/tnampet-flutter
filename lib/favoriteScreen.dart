import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'detailScreen.dart';
import 'medicine.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteScreen> {
  var box;
  List<Medicine> favoritelist = [];
  var item;

  @override
  void initState() {
    super.initState();
    initBox();
  }

  void initBox() async {
    this.box = Hive.box('savedata');
    var data = box.get('medicine') ?? [];
    if (data.isNotEmpty) {
      Iterable list = json.decode(data);
      favoritelist = list.map((e) => Medicine.fromJson(e)).toList();
      favoritelist.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    }
  }

  void clearBox() async {
    favoritelist.clear();
    var text = json.encode(favoritelist);
    box.put('medicine', text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("ថ្នាំសំខាន់ៗ"),
          backgroundColor: Colors.orange,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: IconButton(icon: Icon(Icons.clear_all),onPressed:() {
                  setState(() {
                    clearBox();
                  });
                })),
          ],
        ),
        body: ListView.separated(
          shrinkWrap: true,
          itemCount: favoritelist.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${favoritelist.elementAt(index).title}'),
              onTap: () {
                setState(() {
                  this.item = favoritelist.elementAt(index);
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => DetailScreen(item)))
                      .then((value) => setState(() {
                            initBox();
                          }));
                });
              },
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      );
}
