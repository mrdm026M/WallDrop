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
      body: SafeArea(
        child: Container(
          color: HexColor("#101321"),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150.0,
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Category",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 60.0,
                        height: 50.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            size: 30.0,
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
                  padding: const EdgeInsets.all(10.0),
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
              borderRadius: BorderRadius.circular(12.5),
              child: Image.asset(
                imgUrl,
                width: double.infinity,
                height: 150,
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
                      fontFamily: "PastelColors",
                      letterSpacing: 2.5,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
