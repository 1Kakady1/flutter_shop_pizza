import 'package:pizza_time/redux/state/products/products.actions.dart';
import 'package:pizza_time/redux/state/products/products.model.dart';
import 'package:redux/redux.dart';

Reducer<Products> productsReducer = combineReducers([
  new TypedReducer<Products, SetProductsAction>(_setProducts),
]);

Products _setProducts(Products state, SetProductsAction action) {
  return state.copyWith(
      products: action.products, error: action.error, isLoad: action.isLoad);
}
