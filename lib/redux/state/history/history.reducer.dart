import 'package:pizza_time/redux/state/history/history.actions.dart';
import 'package:pizza_time/redux/state/history/history.model.dart';
import 'package:redux/redux.dart';

Reducer<HistoryModelState> historyReducer = combineReducers([
  new TypedReducer<HistoryModelState, SetHistoryAction>(_setHistory),
  new TypedReducer<HistoryModelState, RequestHistorySuccessAction>(
      _requestHistorySuccess),
  new TypedReducer<HistoryModelState, RequestHistoryAction>(_requestHistory),
  new TypedReducer<HistoryModelState, RequestHistoryErrorAction>(
      _requestHistoryError),
]);

HistoryModelState _setHistory(
    HistoryModelState state, SetHistoryAction action) {
  return state.copyWith(
      history: action.history, error: action.error, isLoad: action.isLoad);
}

HistoryModelState _requestHistory(
    HistoryModelState state, RequestHistoryAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}

HistoryModelState _requestHistorySuccess(
    HistoryModelState state, RequestHistorySuccessAction action) {
  return state.copyWith(
      history: [...state.history, ...action.history],
      error: action.error,
      isLoad: action.isLoad,
      offset: action.offset);
}

HistoryModelState _requestHistoryError(
    HistoryModelState state, RequestHistoryErrorAction action) {
  return state.copyWith(error: action.error, isLoad: action.isLoad);
}
