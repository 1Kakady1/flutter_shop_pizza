import 'package:pizza_time/redux/state/history/history.model.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:reselect/reselect.dart';

class HistorySelectors {
  static final history = createSelector1(
    AppSelectors.historySelector,
    (HistoryModelState history) => history.history,
  );

  static final isLoad = createSelector1(
    AppSelectors.historySelector,
    (HistoryModelState history) => history.isLoad,
  );

  static final error = createSelector1(
    AppSelectors.historySelector,
    (HistoryModelState history) => history.error,
  );

  static final offset = createSelector1(
    AppSelectors.historySelector,
    (HistoryModelState history) => history.offset,
  );

  static final toProducts = createSelector1(
    AppSelectors.historySelector,
    (HistoryModelState history) => history,
  );
}
