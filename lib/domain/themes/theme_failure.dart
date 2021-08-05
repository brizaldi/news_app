import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_failure.freezed.dart';

@freezed
class ThemeFailure with _$ThemeFailure {
  const factory ThemeFailure.cacheError() = CacheError;
}
