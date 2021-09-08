import 'package:pizza_time/redux/state/home/home.actions.dart';
import 'package:pizza_time/redux/state/home/home.model.dart';
import 'package:redux/redux.dart';

Reducer<HomeModelState> homeReducer = combineReducers([
  new TypedReducer<HomeModelState, SetHomeAction>(_setHome),
  new TypedReducer<HomeModelState, ChangeProductsHomeAction>(
      _changeProductsHome),
]);

HomeModelState _setHome(HomeModelState state, SetHomeAction action) {
  return state.copyWith(
      products: action.products, error: action.error, isLoad: action.isLoad);
}

HomeModelState _changeProductsHome(
    HomeModelState state, ChangeProductsHomeAction action) {
  return state.copyWith(products: action.products, error: "", isLoad: false);
}
