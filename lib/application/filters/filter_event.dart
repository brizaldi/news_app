part of 'filter_bloc.dart';

@freezed
class FilterEvent with _$FilterEvent {
  const factory FilterEvent.categoryChanged({
    required Category category,
  }) = _CategoryChanged;

  const factory FilterEvent.keywordChanged({
    required String keyword,
  }) = _KeywordChanged;
}
