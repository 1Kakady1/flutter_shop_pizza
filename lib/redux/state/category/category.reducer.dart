import 'package:pizza_time/redux/state/category/category.actions.dart';
import 'package:pizza_time/redux/state/category/category.model.dart';
import 'package:redux/redux.dart';

Reducer<CategoryModelState> categorysReducer = combineReducers([
  new TypedReducer<CategoryModelState, SetCategorysAction>(_setCategorys),
  new TypedReducer<CategoryModelState, ChangeCategorysAction>(_changeCategory),
  new TypedReducer<CategoryModelState, ChangeCategorysSliverAction>(
      _changeCategorySliver),
  new TypedReducer<CategoryModelState, CategorysRequestAction>(
      _requestCategory),
  new TypedReducer<CategoryModelState, CategorysRequestSuccessAction>(
      _requestCategorySuccess),
  new TypedReducer<CategoryModelState, CategorysRequestErrorAction>(
      _requestCategoryError),
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

CategoryModelState _requestCategory(
    CategoryModelState state, CategorysRequestAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}

CategoryModelState _requestCategorySuccess(
    CategoryModelState state, CategorysRequestSuccessAction action) {
  return state.copyWith(categorys: action.categorys, error: "", isLoad: false);
}

CategoryModelState _requestCategoryError(
    CategoryModelState state, CategorysRequestErrorAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}
