import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walpy/main.dart';

class ImageView extends StatefulWidget {
  final String mainUrl;
  final String imgUrl;
  ImageView({Key key, this.imgUrl, this.mainUrl}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool downloading = false;
  var progressString = "";

  Future<void> downloadFile() async {
    Dio dio = Dio();
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
      try {
        var url = widget.mainUrl.toString();
        List<String> value = url.split("https://www.pexels.com/photo/");
        String newName = value[1].toString();
        String newFile = newName.substring(0, newName.length - 1);
        await dio.download(widget.imgUrl, "${directory.path}/$newFile.jpeg",
            onReceiveProgress: (rec, total) {
          print("Rec: $rec, Total: $total");
          setState(() {
            downloading = true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        });
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download Completed");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor("#101118"),
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgUrl,
            child: Container(
              color: HexColor("#101118"),
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
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 35.0,
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
          downloading
              ? Center(
                  child: Container(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Card(
                      color: Colors.black.withOpacity(0.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 27.5,
                          ),
                          Text(
                            "Downloading file",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Ubuntu",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  // color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            // color: HexColor("#101118"),
                            width: 55.0,
                            height: 55.0,
                            margin: EdgeInsets.only(bottom: 65.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white60, width: 1),
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
                                downloadFile();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 12.5,
                      ),
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
}

// _save() async {
//   Directory directory;

//   if (await directory.exists()) {
//     var url = widget.mainUrl.toString();
//     print(url);
//     List<String> value = url.split("https://www.pexels.com/photo/");
//     String newName = value[1].toString();
//     String newFile = newName.substring(0, newName.length - 1);
//     print(newFile);
//     File saveFile = File(directory.path + "/$newFile.jpeg");
//     print(saveFile);
//     String file = directory.path + "/";
//     print("url-" + file);
// await Dio().download(widget.imgUrl, saveFile,
// options: Options(responseType: ResponseType.bytes));
// try {

//   // final result = await ImageGallerySaver.saveFile(file);
//   // print(result);
// } catch (e) {
//   print(e);
// }
// }
// }

// }
