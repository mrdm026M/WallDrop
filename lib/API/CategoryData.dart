import 'package:walpy/Model/CategoryModel.dart';

List<CategoryModel> getCatgories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  //City Category
  categoryModel.imgURL = "assets/images/city1.jpg";
  categoryModel.categoriesName = "City";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Wildlife Category
  categoryModel.imgURL = "assets/images/wildlife1.jpg";
  categoryModel.categoriesName = "WildLife";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
