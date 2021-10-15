import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/state/products/products.model.dart';
import 'package:redux/redux.dart';

Reducer<Products> productsReducer = combineReducers([
  new TypedReducer<Products, SetProductsAction>(_setProducts),
  new TypedReducer<Products, GotoCategoryProducts>(_gotoCategoryProducts),
  new TypedReducer<Products, RequestProductsSuccessAction>(
      _requestProductsSuccess),
  new TypedReducer<Products, RequestProductsAction>(_requestProducts),
  new TypedReducer<Products, RequestProductsErrorAction>(_requestProductsError),
]);

Products _setProducts(Products state, SetProductsAction action) {
  return state.copyWith(
      products: action.products, error: action.error, isLoad: action.isLoad);
}

Products _gotoCategoryProducts(Products state, GotoCategoryProducts action) {
  return state.copyWith(isLoad: action.isLoad, error: action.error);
}

Products _requestProducts(Products state, RequestProductsAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}

Products _requestProductsSuccess(
    Products state, RequestProductsSuccessAction action) {
  return state.copyWith(
      products: action.products, error: action.error, isLoad: action.isLoad);
}

Products _requestProductsError(
    Products state, RequestProductsErrorAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}
