// import 'dart:io';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

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
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff1c1b1b).withOpacity(0.8),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                        height: 62.5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 62.5,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white60, width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Download Wallpaper",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Image saved in Gallery",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
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
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    // Navigator.pop(context);
  }

  _askPermission() async {
    // PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.camera,
      ].request();
      print(statuses[
          Permission.storage]); // it should print PermissionStatus.granted
    }
  }
}

// _save() async {
//   if (Platform.isAndroid) {
//     await _askPermission();
//   }

//   // await _askPermission();
//   var response = await Dio()
//       .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
//   final result =
//       await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
//   print(result);
//   Navigator.pop(context);
// }

// _askPermission() async {
//   if (Platform.isAndroid) {
//   Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermission([PermissionGroup.photos]);
// } else {
//   PermissionStatus permissions = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
// }
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//       Permission.camera,
//     ].request();
//     print(statuses[Permission.storage]);
//   }
// }

// _askPermission() async {
//   var status = await Permission.storage.request().isGranted;
//   if (await Permission.storage.requestIfDenied().isGranted) {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//       Permission.camera,
//     ].request();
//     print(statuses[Permission.storage]);
//   }
// }