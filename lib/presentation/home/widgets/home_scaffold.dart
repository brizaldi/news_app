import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/filters/filter_bloc.dart';
import '../../../application/themes/theme_cubit.dart';
import '../../../extra/style/style.dart';
import '../../../extra/utils/datetime_helper.dart';
import 'custom_search_delegate.dart';
import 'home_body.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'News App',
              style: textTheme.headline6!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateTime.now().formattedString(),
              style: textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.normal,
                color: Palette.dustyGray,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _onTapSearch(context),
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            tooltip: 'Dark Mode',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }

  Future<void> _onTapSearch(BuildContext context) async {
    final _filterBloc = context.read<FilterBloc>();

    final _result = await showSearch(
      context: context,
      query: _filterBloc.state.keyword,
      delegate: CustomSearchDelegate(),
    );

    if (_result != null) {
      _filterBloc.add(FilterEvent.keywordChanged(keyword: _result));
    }
  }
}
