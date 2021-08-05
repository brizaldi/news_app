import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../domain/themes/i_theme_repository.dart';
import '../../domain/themes/theme_failure.dart';
import 'theme_local_datasource.dart';

@LazySingleton(as: IThemeRepository)
class ThemeRepository implements IThemeRepository {
  ThemeRepository(
    this._localDataSource,
  );

  final IThemeLocalDataSource _localDataSource;

  @override
  Future<Either<ThemeFailure, bool>> getTheme() async {
    try {
      final _isDarkMode = await _localDataSource.getTheme();
      return right(_isDarkMode);
    } on CacheException {
      return left(const ThemeFailure.cacheError());
    }
  }

  @override
  Future<Either<ThemeFailure, bool>> setTheme({
    required bool isDarkMode,
  }) async {
    try {
      await _localDataSource.setTheme(
        isDarkMode: isDarkMode,
      );
      return right(isDarkMode);
    } on CacheException {
      return left(const ThemeFailure.cacheError());
    }
  }
}
