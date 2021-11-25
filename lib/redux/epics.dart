import 'package:pizza_time/redux/effects/category.effect.dart';
import 'package:pizza_time/redux/effects/product.effect.dart';
import 'package:pizza_time/redux/effects/products.effect.dart';
import 'package:pizza_time/redux/state/home/home.effect.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/widgets/carusel-category/carusel-category.effect.dart';
import 'package:pizza_time/redux/effects/popular.effect.dart';
import 'package:redux_epics/redux_epics.dart';

import 'effects/user.effect.dart';

final epic = combineEpics<AppState>([
  changeCatHomeEpic,
  getHomeContnent,
  gotoAllCategoryProducts,
  changeProductsTheCategory,
  effectGetProductByID,
  effectGetProducts,
  effectGetCategorys,
  setUserEffect
]);
