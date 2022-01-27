import 'package:pizza_time/model/order.model.dart';

class HistoryModelState {
  final List<OrderModel> history;
  final bool isLoad;
  final String error;
  final offset;

  HistoryModelState(
      {required this.history,
      required this.isLoad,
      required this.error,
      this.offset});

  factory HistoryModelState.initial() =>
      HistoryModelState(history: [], isLoad: true, error: "", offset: null);

  HistoryModelState copyWith({history, isLoad, error, offset}) {
    return HistoryModelState(
        history: history ?? this.history,
        isLoad: isLoad ?? this.isLoad,
        error: error ?? this.error,
        offset: offset ?? this.offset);
  }
}
