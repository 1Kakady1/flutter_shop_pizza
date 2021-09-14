import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/home/home.model.dart';
import 'package:redux/redux.dart';

Reducer<HomeModelState> homeReducer = combineReducers([
  new TypedReducer<HomeModelState, RequestHomeSuccess>(_requestHomeSuccess),
  new TypedReducer<HomeModelState, RequestHome>(_requestHome),
  new TypedReducer<HomeModelState, RequestHomeError>(_requestHomeError),
  new TypedReducer<HomeModelState, ChangeProductsHomeAction>(
      _changeProductsHome),
  new TypedReducer<HomeModelState, ChangeHomeCategorysAction>(
      _changeHomeCategory),
]);

HomeModelState _requestHomeSuccess(
    HomeModelState state, RequestHomeSuccess action) {
  return state.copyWith(
      products: action.products,
      cat: action.cat,
      error: action.error,
      isLoad: action.isLoad);
}

HomeModelState _requestHome(HomeModelState state, RequestHome action) {
  return state.copyWith(isLoad: action.isLoad);
}

HomeModelState _requestHomeError(
    HomeModelState state, RequestHomeError action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}

HomeModelState _changeProductsHome(
    HomeModelState state, ChangeProductsHomeAction action) {
  return state.copyWith(products: action.products, error: "", isLoad: false);
}

HomeModelState _changeHomeCategory(
    HomeModelState state, ChangeHomeCategorysAction action) {
  return state.copyWith(currentCat: action.currentCat);
}
