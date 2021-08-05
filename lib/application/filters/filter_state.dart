part of 'filter_bloc.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    required Category category,
    required String keyword,
  }) = _FilterState;

  factory FilterState.initial() => FilterState(
        category: Category.empty(),
        keyword: '',
      );
}
