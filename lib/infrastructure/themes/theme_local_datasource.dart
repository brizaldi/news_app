import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../extra/constants/strings.dart';
import '../../extra/utils/logging.dart';

abstract class IThemeLocalDataSource {
  Future<bool> getTheme();

  Future<void> setTheme({required bool isDarkMode});
}

@LazySingleton(as: IThemeLocalDataSource)
class ThemeLocalDataSource implements IThemeLocalDataSource {
  ThemeLocalDataSource(this._box);

  final Box _box;

  @override
  Future<bool> getTheme() async {
    try {
      final _isDarkMode = _box.get(Strings.isDarkMode);
      if (_isDarkMode == null) return true;

      return _isDarkMode == 'true';
    } catch (e, s) {
      Log.severe(e.toString());
      Log.severe(s.toString());
      throw CacheException();
    }
  }

  @override
  Future<void> setTheme({required bool isDarkMode}) async {
    try {
      return _box.put(
        Strings.isDarkMode,
        isDarkMode.toString(),
      );
    } catch (e, s) {
      Log.severe(e.toString());
      Log.severe(s.toString());
      throw CacheException();
    }
  }
}
