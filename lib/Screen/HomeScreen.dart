import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:walpy/API/Api.dart';
import 'package:walpy/Model/ApiModel.dart';
import 'package:http/http.dart' as http;
import 'package:walpy/Screen/SearchScreen.dart';
import 'package:walpy/Widget/WallpaperWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ApiModel> _wallpapers = [];

  getTrendingWallpaper() async {
    var response = await http.get(
      "https://api.pexels.com/v1/curated?per_page=60",
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach(
      (element) {
        ApiModel apiModel = new ApiModel();
        apiModel = ApiModel.fromMap(element);
        _wallpapers.add(apiModel);
      },
    );

    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpaper();
    super.initState();
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
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            "WallDrop",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.25,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 27.5,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: wallpapersList(
                      wallpapers: _wallpapers,
                      context: context,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
