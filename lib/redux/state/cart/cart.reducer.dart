import 'package:pizza_time/model/cart.model.dart';
import 'package:pizza_time/redux/state/cart/cart.action.dart';
import 'package:pizza_time/redux/state/cart/cart.model.dart';
import 'package:redux/redux.dart';

Reducer<CartModelState> cartReducer = combineReducers([
  new TypedReducer<CartModelState, CartAddAction>(_addCartProduct),
  new TypedReducer<CartModelState, CartSubAction>(_subCartProduct),
  new TypedReducer<CartModelState, CartRemoveAction>(_removeCartProduct),
  new TypedReducer<CartModelState, CartClearAction>(_clearCartProduct),
]);

CartModelState _addCartProduct(CartModelState state, CartAddAction action) {
  dynamic prod = action.product != null
      ? action.product
      : action.cartItem != null
          ? action.cartItem
          : null;
  List<CartItem> items = [...state.products];
  if (prod != null) {
    int item = [...state.products]
        .indexWhere((x) => x.id == prod.id && x.productSize == action.size);
    if (item == -1) {
      items.add(CartItem(
          title: prod.title,
          price: prod.price,
          preview: prod.preview,
          filter: prod.filter,
          id: prod.id,
          cat: action.product != null
              ? action.product!.cat[0]
              : action.cartItem!.cat ?? "",
          count: 1,
          isUnit: action.product?.isUnit ?? false,
          productSize: action.size));
    } else {
      items[item] = items[item].copyWith(count: items[item].count + 1);
    }
  }

  return state.copyWith(products: items.toList());
}

CartModelState _subCartProduct(CartModelState state, CartSubAction action) {
  List<CartItem> items = [...state.products];
  dynamic prod = action.product != null
      ? action.product
      : action.cartItem != null
          ? action.cartItem
          : null;
  if (prod != null) {
    int item = [...state.products]
        .indexWhere((x) => x.id == prod.id && x.productSize == action.size);

    if (item != -1 && state.products[item].count - 1 > 0) {
      items[item] = items[item].copyWith(count: items[item].count - 1);
    } else if (item != -1 && state.products[item].count - 1 <= 0) {
      items.removeAt(item);
    }
  }

  return state.copyWith(products: items);
}

CartModelState _removeCartProduct(
    CartModelState state, CartRemoveAction action) {
  int item = [...state.products].indexWhere(
      (x) => x.id == action.product.id && x.productSize == action.size);
  List<CartItem> items = [...state.products];

  if (item != -1) {
    items.removeAt(item);
  }

  return state.copyWith(products: items);
}

CartModelState _clearCartProduct(CartModelState state, CartClearAction action) {
  return state.copyWith(products: []);
}
