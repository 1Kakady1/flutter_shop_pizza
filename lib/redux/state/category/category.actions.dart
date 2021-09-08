import 'package:pizza_time/api/api.dart';
import 'package:pizza_time/model/category.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final Api _api = Api();

class SetCategorysAction {
  List<Category> categorys;
  bool isLoad;
  String error;

  SetCategorysAction(
      {required this.categorys, required this.error, required this.isLoad});
}

class ChangeCategorysAction {
  final String currentCat;
  ChangeCategorysAction({required this.currentCat});
}

ThunkAction getCategorys = (Store store) async {
  _api
      .getCategoryes()
      .then((value) => {
            store.dispatch(
                SetCategorysAction(categorys: value, error: "", isLoad: false))
          })
      .catchError((e) => store.dispatch(SetCategorysAction(
          categorys: [], error: e.toString(), isLoad: false)));
};
