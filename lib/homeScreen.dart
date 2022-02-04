import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tnampet/medicine.dart';

class HomeScreen extends StatefulWidget {
  List<Medicine> medicinelist = [];
  HomeScreen(List<Medicine> medicinelist) {
    this.medicinelist = medicinelist;
  }

  @override
  _HomeState createState() => _HomeState(medicinelist);
}

class _HomeState extends State<HomeScreen> {
  List<Medicine> medicinelist = [];
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  _HomeState(List<Medicine> medicinelist) {
    this.medicinelist = medicinelist;
    this.items.addAll(duplicateItems);
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white38,
        body: Container(
          alignment: Alignment.center,
          child: (medicinelist.isEmpty)
              ? CircularProgressIndicator()
              : Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('${items[index]}'),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
}
