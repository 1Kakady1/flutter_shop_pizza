import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/category/category.model.dart';
import 'package:redux/redux.dart';

Reducer<CategoryModelState> categorysReducer = combineReducers([
  new TypedReducer<CategoryModelState, SetCategorysAction>(_setCategorys),
  new TypedReducer<CategoryModelState, ChangeCategorysAction>(_changeCategory),
  new TypedReducer<CategoryModelState, ChangeCategorysSliverAction>(
      _changeCategorySliver),
]);

CategoryModelState _setCategorys(
    CategoryModelState state, SetCategorysAction action) {
  return state.copyWith(
      categorys: action.categorys, error: action.error, isLoad: action.isLoad);
}

CategoryModelState _changeCategory(
    CategoryModelState state, ChangeCategorysAction action) {
  return state.copyWith(currentCat: action.currentCat);
}

//!TODO: убрать повторение
CategoryModelState _changeCategorySliver(
    CategoryModelState state, ChangeCategorysSliverAction action) {
  return state.copyWith(currentCat: action.currentCat);
}