import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:walpy/API/Api.dart';
import 'package:walpy/Model/ApiModel.dart';
import 'package:http/http.dart' as http;
import 'package:walpy/Widget/WallpaperWidget.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;

  SearchScreen({Key key, this.searchQuery}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ApiModel> wallpapers = [];
  TextEditingController searchController = new TextEditingController();

  getSearchWallpaper(String query) async {
    // var headers = "Authorization: $apiKey";
    // var url = "https://api.pexels.com/v1/search?query=$query&per_page=16";
    // var response = await http.get(
    //   Uri.https(url, headers),
    // );

    // Map<String, dynamic> jsonData = jsonDecode(response.body);
    // jsonData["photos"].forEach((element) {
    //   ApiModel apiModel = new ApiModel();
    //   apiModel = ApiModel.fromMap(element);
    //   wallpapers.add(apiModel);
    // });

    // setState(() {});

    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=16",
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach(
      (element) {
        ApiModel apiModel = new ApiModel();
        apiModel = ApiModel.fromMap(element);
        wallpapers.add(apiModel);
      },
    );

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          elevation: 1.0,
          title: Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            getSearchWallpaper(searchController.text);
                          },
                          child: Container(child: Icon(Icons.search))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child:
                      wallpapersList(wallpapers: wallpapers, context: context),
                ),
              ],
            ),
          ),
        ));
  }
}
