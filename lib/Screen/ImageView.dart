import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:walpy/Permissions/Permissions_Service.dart';
// import 'package:walpy/Permissions/Permissions_Service.dart';
import 'package:walpy/main.dart';

class ImageView extends StatefulWidget {
  final String mainUrl;
  final String imgUrl;
  ImageView({Key key, this.imgUrl, this.mainUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.cover,
                ),
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
    Directory directory;
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();
        print(directory.path);
        String newPath = "";
        List<String> folders = directory.path.split("/");

        for (int x = 1; x < folders.length; x++) {
          String folder = folders[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }

        newPath = newPath + "/WallDrop";

        directory = Directory(newPath);
        print(directory.path);
      } else {
        return false;
      }
    } else {
      return false;
    }

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    if (await directory.exists()) {
      var url = widget.mainUrl.toString();
      print(url);
      List<String> value = url.split("https://www.pexels.com/photo/");
      String newName = value[1].toString();
      String newFile = newName.substring(0, newName.length - 1);
      print(newFile);
      File saveFile = File(directory.path + "/$newFile.jpeg");
      print(saveFile);
      String file = directory.path + "/";
      print("url-" + file);
      await Dio().download(widget.imgUrl, saveFile,
          options: Options(responseType: ResponseType.bytes));
      // try {

      //   // final result = await ImageGallerySaver.saveFile(file);
      //   // print(result);
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
