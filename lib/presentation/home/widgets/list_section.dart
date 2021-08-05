import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../application/filters/filter_bloc.dart';
import '../../../application/news/news_watcher/news_watcher_bloc.dart';
import '../../../extra/constants/strings.dart';
import '../../../extra/style/style.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/load_more_indicator.dart';
import 'list_item.dart';

class ListSection extends HookWidget {
  const ListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    _scrollController.addListener(() => _onScroll(context, _scrollController));

    return BlocBuilder<NewsWatcherBloc, NewsWatcherState>(
      builder: (context, state) {
        return state.status.maybeMap(
          orElse: () => const Center(
            child: CircularProgressIndicator(color: Palette.amaranth),
          ),
          failure: (_) => ErrorView(
            message: state.failureOrSuccessOption.fold(
              () => '',
              (either) => either.fold(
                (failure) => failure.map(
                  serverError: (_) => Strings.serverErrorMessage,
                  noConnectionError: (_) => Strings.noConnectionErrorMessage,
                ),
                (r) => '',
              ),
            ),
            onRetry: () => _onRetry(context),
          ),
          success: (_) => RefreshIndicator(
            color: Palette.amaranth,
            onRefresh: () async => _onRetry(context),
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.hasReachedMax
                  ? state.listNews.length
                  : state.listNews.length + 1,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 18);
              },
              itemBuilder: (context, index) {
                if (index >= state.listNews.length) {
                  return const LoadMoreIndicator();
                }

                return ListItem(news: state.listNews[index]);
              },
            ),
          ),
        );
      },
    );
  }

  void _onRetry(BuildContext context) {
    final _currentFilter = context.read<FilterBloc>().state;
    context
        .read<NewsWatcherBloc>()
        .add(NewsWatcherEvent.refreshed(filter: _currentFilter));
  }

  void _onScroll(BuildContext context, ScrollController scrollController) {
    if (_isBottom(scrollController)) {
      final _currentFilter = context.read<FilterBloc>().state;

      context.read<NewsWatcherBloc>().add(NewsWatcherEvent.fetched(
            filter: _currentFilter,
          ));
    }
  }

  bool _isBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
