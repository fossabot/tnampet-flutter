import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tnampet/medicine.dart';

import 'detailScreen.dart';

class HomeScreen extends StatefulWidget {
  List<Medicine> medicinelist = [];
  var pageController;
  HomeScreen(List<Medicine> medicinelist, PageController pageController) {
    this.medicinelist = medicinelist;
    this.pageController = pageController;
  }

  @override
  _HomeState createState() => _HomeState(medicinelist);
}

class _HomeState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  List<Medicine> medicinelist = [];
  TextEditingController editingController = TextEditingController();
  var items = [];
  var item;

  _HomeState(List<Medicine> medicinelist) {
    this.medicinelist = medicinelist;
    this.items.addAll(medicinelist);
    log(medicinelist.elementAt(0).title);
  }

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(medicinelist);
    if (query.isNotEmpty) {
      var dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title.toString().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(medicinelist);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: (medicinelist.isEmpty)
              ? Text("Data cannot fetch.",textAlign: TextAlign.center,)
              : Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: false,
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(4),
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)))),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('${items.elementAt(index).title}'),
                              onTap: () {
                                setState(() {
                                  this.item = items.elementAt(index);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailScreen(item)));
                                });
                              },
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
