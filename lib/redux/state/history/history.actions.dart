import 'package:pizza_time/model/order.model.dart';

class RequestHistoryAction {
  bool isLoad;
  String error;
  String id;
  dynamic offset;
  RequestHistoryAction(
      {required this.error,
      required this.isLoad,
      required this.id,
      this.offset});
}

class RequestHistorySuccessAction {
  List<OrderModel> history;
  bool isLoad;
  String error;
  dynamic offset;
  RequestHistorySuccessAction(
      {required this.history,
      required this.error,
      required this.isLoad,
      this.offset});
}

class RequestHistoryErrorAction {
  bool isLoad;
  String error;
  dynamic offset;
  RequestHistoryErrorAction(
      {required this.error, required this.isLoad, this.offset});
}

class SetHistoryAction {
  List<OrderModel> history;
  bool isLoad;
  String error;

  SetHistoryAction(
      {required this.history, required this.error, required this.isLoad});
}
