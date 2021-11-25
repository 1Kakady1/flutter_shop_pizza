import 'package:pizza_time/redux/state/user/user.actions.dart';
import 'package:pizza_time/redux/state/user/user.model.dart';
import 'package:redux/redux.dart';

Reducer<UserModelState> userReducer = combineReducers([
  new TypedReducer<UserModelState, ChangeAuthAction>(_changeAuth),
  new TypedReducer<UserModelState, SetUser>(_setUser),
  new TypedReducer<UserModelState, UserRequestAction>(_requestUser),
  new TypedReducer<UserModelState, UserRequestSuccessAction>(
      _requestUserSuccess),
  new TypedReducer<UserModelState, UserRequestErrorAction>(_requestUserError),
]);

UserModelState _changeAuth(UserModelState state, ChangeAuthAction action) {
  return state.copyWith(isAuth: action.isAuth);
}

UserModelState _setUser(UserModelState state, SetUser action) {
  return state.copyWith(isAuth: action.isAuth, user: action.user);
}

UserModelState _requestUser(UserModelState state, UserRequestAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}

UserModelState _requestUserSuccess(
    UserModelState state, UserRequestSuccessAction action) {
  return state.copyWith(
      user: action.user, isAuth: true, error: "", isLoad: false);
}

UserModelState _requestUserError(
    UserModelState state, UserRequestErrorAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}
