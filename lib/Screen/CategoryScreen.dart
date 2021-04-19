import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:walpy/API/CategoryData.dart';
import 'package:walpy/Model/CategoryModel.dart';
import 'package:walpy/Screen/Category.dart';
import 'package:walpy/Screen/SearchScreen.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categories = List<CategoryModel>.empty(growable: true);

  @override
  void initState() {
    categories = getCatgories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#101118"),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
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
                          "Collections",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Ubuntu",
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryTile(
                        title: categories[index].categoriesName,
                        imgUrl: categories[index].imgURL,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl;
  final String title;

  CategoryTile({@required this.imgUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Category(
              categoryName: title.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imgUrl,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.5),
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.black38,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Ubuntu",
                    fontSize: 22.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
