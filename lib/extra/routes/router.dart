import 'package:auto_route/auto_route.dart';

import '../../presentation/details/details_page.dart';
import '../../presentation/home/home_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: DetailsPage),
  ],
)
class $AppRouter {}
