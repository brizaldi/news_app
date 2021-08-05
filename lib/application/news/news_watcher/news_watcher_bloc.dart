import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/news/fetch_status.dart';
import '../../../domain/news/i_news_repository.dart';
import '../../../domain/news/news.dart';
import '../../../domain/news/news_failure.dart';
import '../../../extra/utils/logging.dart';
import '../../filters/filter_bloc.dart';

part 'news_watcher_bloc.freezed.dart';
part 'news_watcher_event.dart';
part 'news_watcher_state.dart';

class NewsWatcherBloc extends Bloc<NewsWatcherEvent, NewsWatcherState> {
  NewsWatcherBloc(
    this._newsRepository,
    this._filterBloc,
  ) : super(NewsWatcherState.initial()) {
    _filterSubscription = _filterBloc.stream.listen(_onFilterStateChanged);
  }

  final INewsRepository _newsRepository;
  final FilterBloc _filterBloc;

  late StreamSubscription _filterSubscription;

  @override
  Future<void> close() {
    _filterSubscription.cancel();
    return super.close();
  }

  @override
  void onTransition(
    Transition<NewsWatcherEvent, NewsWatcherState> transition,
  ) {
    Log.info(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onEvent(NewsWatcherEvent event) {
    Log.info(event.toString());
    super.onEvent(event);
  }

  @override
  Stream<Transition<NewsWatcherEvent, NewsWatcherState>> transformEvents(
    Stream<NewsWatcherEvent> events,
    TransitionFunction<NewsWatcherEvent, NewsWatcherState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<NewsWatcherState> mapEventToState(
    NewsWatcherEvent event,
  ) async* {
    yield* event.map(
      fetched: (e) async* {
        yield await _mapFetchedToState(
          state: state,
          filter: e.filter,
        );
      },
      refreshed: (e) async* {
        yield NewsWatcherState.initial();
        add(NewsWatcherEvent.fetched(filter: e.filter));
      },
    );
  }

  Future<NewsWatcherState> _mapFetchedToState({
    required NewsWatcherState state,
    required FilterState filter,
  }) async {
    if (state.hasReachedMax) return state;

    if (state.status == const FetchStatus.initial()) {
      final either = await _getNews(filter: filter);

      return either.fold(
        (failure) => state.copyWith(
          status: const FetchStatus.failure(),
          failureOrSuccessOption: optionOf(either),
        ),
        (listNews) => state.copyWith(
          hasReachedMax: listNews.length < state.limit,
          page: state.page + 1,
          status: const FetchStatus.success(),
          listNews: listNews,
        ),
      );
    }

    final either = await _getNews(filter: filter);

    return either.fold(
      (failure) => state.copyWith(
        status: const FetchStatus.failure(),
        failureOrSuccessOption: optionOf(either),
      ),
      (listNews) {
        if (listNews.isEmpty) {
          return state.copyWith(
            hasReachedMax: true,
            failureOrSuccessOption: none(),
          );
        } else {
          return state.copyWith(
            status: const FetchStatus.success(),
            page: state.page + 1,
            listNews: List.of(state.listNews)..addAll(listNews),
            failureOrSuccessOption: none(),
          );
        }
      },
    );
  }

  Future<Either<NewsFailure, List<News>>> _getNews({
    required FilterState filter,
  }) {
    return _newsRepository.getNews(
      page: state.page,
      limit: state.limit,
      keyword: filter.keyword,
      category: filter.category.value.fold(
        (_) => null,
        (value) => value,
      ),
    );
  }

  void _onFilterStateChanged(FilterState filterState) {
    add(NewsWatcherEvent.refreshed(
      filter: filterState,
    ));
  }
}
