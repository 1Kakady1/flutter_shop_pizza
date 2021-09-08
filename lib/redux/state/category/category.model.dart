import 'package:pizza_time/model/category.model.dart';

class CategoryModelState {
  final List<Category> categorys;
  final String currentCat;
  final bool isLoad;
  final String error;

  CategoryModelState(
      {required this.categorys,
      required this.currentCat,
      required this.isLoad,
      required this.error});

  factory CategoryModelState.initial() => CategoryModelState(
      categorys: [], currentCat: 'all', isLoad: true, error: "");

  CategoryModelState copyWith({categorys, isLoad, error, currentCat}) {
    return CategoryModelState(
        categorys: categorys ?? this.categorys,
        isLoad: isLoad ?? this.isLoad,
        error: error ?? this.error,
        currentCat: currentCat ?? this.currentCat);
  }
}
