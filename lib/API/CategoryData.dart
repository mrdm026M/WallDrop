import 'package:walpy/Model/CategoryModel.dart';

List<CategoryModel> getCatgories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();

  //Black Category
  categoryModel.imgURL = "assets/images/black.jpg";
  categoryModel.categoriesName = "Black";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Fashion Category
  categoryModel.imgURL = "assets/images/fashion.jpg";
  categoryModel.categoriesName = "Fashion";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //History Category
  categoryModel.imgURL = "assets/images/history.jpg";
  categoryModel.categoriesName = "History";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Landscape Category
  categoryModel.imgURL = "assets/images/landscape.jpg";
  categoryModel.categoriesName = "Landscape";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Nature Category
  categoryModel.imgURL = "assets/images/nature.jpg";
  categoryModel.categoriesName = "Nature";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //People Category
  categoryModel.imgURL = "assets/images/people.jpg";
  categoryModel.categoriesName = "People";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Red Category
  categoryModel.imgURL = "assets/images/red.jpg";
  categoryModel.categoriesName = "Red";
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

  //Street Category
  categoryModel.imgURL = "assets/images/street.jpg";
  categoryModel.categoriesName = "Street Photography";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Technology Category
  categoryModel.imgURL = "assets/images/technology.jpg";
  categoryModel.categoriesName = "Technology";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Travel Category
  categoryModel.imgURL = "assets/images/travel.jpg";
  categoryModel.categoriesName = "Travel";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Wallpapers Category
  categoryModel.imgURL = "assets/images/wallpaper.jpg";
  categoryModel.categoriesName = "Wallpapers";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  //Wildlife Category
  categoryModel.imgURL = "assets/images/wildlife.jpg";
  categoryModel.categoriesName = "WildLife";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
