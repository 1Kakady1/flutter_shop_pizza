import 'package:pizza_time/redux/state/user/user.actions.dart';
import 'package:pizza_time/redux/state/user/user.model.dart';
import 'package:redux/redux.dart';

Reducer<UserModelState> userReducer = combineReducers([
  new TypedReducer<UserModelState, ChangeAuthAction>(_changeAuth),
]);

UserModelState _changeAuth(UserModelState state, ChangeAuthAction action) {
  return state.copyWith(isAuth: action.isAuth);
}
