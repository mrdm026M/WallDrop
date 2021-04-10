import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:walpy/API/Api.dart';
import 'package:walpy/Model/ApiModel.dart';
import 'package:http/http.dart' as http;
import 'package:walpy/Widget/WallpaperWidget.dart';

class Category extends StatefulWidget {
  final String categoryName;
  Category({Key key, this.categoryName}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ApiModel> wallpapers = List<ApiModel>.empty(growable: true);

  getSearchWallpaper(String query) async {
    var response = await http.get(
      "https://api.pexels.com/v1/search?query=$query&per_page=60",
      headers: {"Authorization": apiKey},
    );
    print(response);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      ApiModel apiModel = new ApiModel();
      apiModel = ApiModel.fromMap(element);
      wallpapers.add(apiModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpaper(widget.categoryName);
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
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            widget.categoryName.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: wallpapersList(
                    wallpapers: wallpapers,
                    context: context,
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
