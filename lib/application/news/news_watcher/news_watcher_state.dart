part of 'news_watcher_bloc.dart';

@freezed
class NewsWatcherState with _$NewsWatcherState {
  const factory NewsWatcherState({
    required FetchStatus status,
    required bool hasReachedMax,
    required int page,
    required int limit,
    required List<News> listNews,
    required Option<Either<NewsFailure, List<News>>> failureOrSuccessOption,
  }) = _NewsWatcherState;

  factory NewsWatcherState.initial() => NewsWatcherState(
        status: const FetchStatus.initial(),
        hasReachedMax: false,
        page: 1,
        limit: 20,
        listNews: [],
        failureOrSuccessOption: none(),
      );
}
