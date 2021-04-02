import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:walpy/Model/ApiModel.dart';
import 'package:walpy/Screen/ImageView.dart';

Widget wallpapersList({List<ApiModel> wallpapers, context}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgUrl: wallpaper.src.portrait,
                  ),
                ),
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.5),
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ));
        }).toList(),
      ));
}
