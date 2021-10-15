import 'package:pizza_time/model/category.model.dart';

class SetCategorysAction {
  List<Category> categorys;
  bool isLoad;
  String error;

  SetCategorysAction(
      {required this.categorys, required this.error, required this.isLoad});
}

class ChangeCategorysAction {
  final String currentCat;
  ChangeCategorysAction({required this.currentCat});
}

//!TODO: найти способ убрать повторение
class ChangeCategorysSliverAction {
  final String currentCat;
  ChangeCategorysSliverAction({required this.currentCat});
}

class CategorysRequestAction {
  bool isLoad;
  String error;
  CategorysRequestAction({required this.error, required this.isLoad});
}

class CategorysRequestSuccessAction {
  List<Category> categorys;
  bool isLoad;
  String error;

  CategorysRequestSuccessAction(
      {required this.categorys, required this.error, required this.isLoad});
}

class CategorysRequestErrorAction {
  bool isLoad;
  String error;
  CategorysRequestErrorAction({required this.error, required this.isLoad});
}
