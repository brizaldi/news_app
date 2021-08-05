import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/filters/filter_bloc.dart';
import '../../application/news/news_watcher/news_watcher_bloc.dart';
import '../../domain/news/i_news_repository.dart';
import '../../extra/injection/injection.dart';
import 'widgets/home_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilterBloc(),
        ),
        BlocProvider(
          create: (context) => NewsWatcherBloc(
            getIt<INewsRepository>(),
            BlocProvider.of<FilterBloc>(context),
          )..add(NewsWatcherEvent.fetched(filter: FilterState.initial())),
        ),
      ],
      child: const HomeScaffold(),
    );
  }
}
