part of 'news_watcher_bloc.dart';

@freezed
class NewsWatcherEvent with _$NewsWatcherEvent {
  const factory NewsWatcherEvent.fetched({
    required FilterState filter,
  }) = _Fetched;

  const factory NewsWatcherEvent.refreshed({
    required FilterState filter,
  }) = _Refreshed;
}
