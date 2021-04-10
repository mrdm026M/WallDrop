import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:walpy/API/Api.dart';
import 'package:walpy/Model/ApiModel.dart';
import 'package:http/http.dart' as http;
import 'package:walpy/Widget/WallpaperWidget.dart';
import 'package:walpy/main.dart';

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
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=60",
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
        backgroundColor: HexColor("#101118"),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    color: HexColor("#101118"),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    // height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 27.5,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyApp(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              "Search Wallpapers",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff5f8fd),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none,
                            ),
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
                    child: wallpapersList(
                        wallpapers: wallpapers, context: context),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
