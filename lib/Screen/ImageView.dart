import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:walpy/Permissions/Permissions_Service.dart';
import 'package:walpy/main.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({Key key, this.imgUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.topLeft,
              // color: Colors.white,
              margin: EdgeInsets.only(left: 5.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40.0,
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
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        // color: HexColor("#101118"),
                        width: 55.0,
                        height: 55.0,
                        margin: EdgeInsets.only(bottom: 65.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ],
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.download_sharp,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          onPressed: () {
                            _save();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 12.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // color: HexColor("#101118"),
                    width: 55.0,
                    height: 55.0,
                    margin: EdgeInsets.only(bottom: 65.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36FFFFFF),
                          Color(0x0FFFFFFF),
                        ],
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 40.0,
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
                  height: 75,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      PermissionsService().requestStoragePermission(onPermissionDenied: () {
        print("Permission has been denied");
      });
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
    );
    print(result);
  }
}
