import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/themes/i_theme_repository.dart';
import '../../extra/utils/logging.dart';

@injectable
class ThemeCubit extends Cubit<bool> {
  ThemeCubit(this._themeRepository) : super(true);

  final IThemeRepository _themeRepository;

  @override
  void onChange(Change<bool> change) {
    Log.info(change.toString());
    super.onChange(change);
  }

  Future<void> initializeTheme() async {
    final _either = await _themeRepository.getTheme();
    _either.fold(
      (failure) => emit(true),
      (value) {
        Log.info('Dark mode is ${value.toString()}');
        emit(value);
      },
    );
  }

  Future<void> toggleTheme() async {
    final _either = await _themeRepository.setTheme(isDarkMode: !state);
    _either.fold(
      (failure) {},
      (value) {
        Log.info('Dark mode is ${value.toString()}');
        emit(value);
      },
    );
  }
}
