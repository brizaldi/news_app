import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/themes/theme_cubit.dart';
import 'extra/config/configuration.dart';
import 'extra/constants/strings.dart';
import 'extra/injection/injection.dart';
import 'extra/routes/router.gr.dart';
import 'extra/style/style.dart';

void main() => Main();

class Main extends Env {
  @override
  FutureOr<StatelessWidget> onCreate() {
    ErrorWidget.builder = (details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };

    return Application();
  }
}

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeCubit>()..initializeTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: Strings.appName,
            theme: Themes.lightTheme(context),
            darkTheme: Themes.darkTheme(context),
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
