import 'package:walpy/Model/CategoryModel.dart';

List<CategoryModel> getCatgories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  //Black Category
  categoryModel.imgURL = "assets/images/black.jpg";
  categoryModel.categoriesName = "Black";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Cities Category
  categoryModel.imgURL = "assets/images/cities.jpg";
  categoryModel.categoriesName = "Cities";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Fashion Category
  categoryModel.imgURL = "assets/images/fashion.jpg";
  categoryModel.categoriesName = "Fashion";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Landscape Category
  categoryModel.imgURL = "assets/images/landscape.jpg";
  categoryModel.categoriesName = "Landscape";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Space Category
  categoryModel.imgURL = "assets/images/space.jpg";
  categoryModel.categoriesName = "Space";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Sports Category
  categoryModel.imgURL = "assets/images/sport.jpg";
  categoryModel.categoriesName = "Sports";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Wildlife Category
  categoryModel.imgURL = "assets/images/wildlife.jpg";
  categoryModel.categoriesName = "WildLife";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
