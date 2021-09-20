import 'package:pizza_time/redux/state/product/product.actions.dart';
import 'package:pizza_time/redux/state/product/product.model.dart';
import 'package:redux/redux.dart';

Reducer<ProductModelState> productReducer = combineReducers([
  new TypedReducer<ProductModelState, RequestProductAction>(_requestProduct),
  new TypedReducer<ProductModelState, RequestProductSuccessAction>(
      _requestProductSuccess),
  new TypedReducer<ProductModelState, RequestProductErrorAction>(
      _requestProductError),
  new TypedReducer<ProductModelState, ChangeProductSize>(_onChangeProductSize),
]);

ProductModelState _requestProduct(
    ProductModelState state, RequestProductAction action) {
  return state.copyWith(
    error: action.error,
    isLoad: action.isLoad,
  );
}

ProductModelState _requestProductSuccess(
    ProductModelState state, RequestProductSuccessAction action) {
  return state.copyWith(
      product: action.products,
      error: action.error,
      isLoad: action.isLoad,
      size: action.size);
}

ProductModelState _requestProductError(
    ProductModelState state, RequestProductErrorAction action) {
  return state.copyWith(
    error: action.error,
    isLoad: action.isLoad,
  );
}

ProductModelState _onChangeProductSize(
    ProductModelState state, ChangeProductSize action) {
  return state.copyWith(size: action.size);
}
