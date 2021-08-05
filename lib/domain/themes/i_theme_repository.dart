import 'package:dartz/dartz.dart';

import 'theme_failure.dart';

abstract class IThemeRepository {
  Future<Either<ThemeFailure, bool>> getTheme();

  Future<Either<ThemeFailure, bool>> setTheme({required bool isDarkMode});
}
