import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/news/news_source.dart';
import '../../../domain/news/value_objects.dart';

part 'news_source_dtos.freezed.dart';
part 'news_source_dtos.g.dart';

@freezed
class NewsSourceDto with _$NewsSourceDto {
  const factory NewsSourceDto({
    @JsonKey(name: 'name') required String sourceName,
  }) = _NewsSourceDto;

  const NewsSourceDto._();

  factory NewsSourceDto.fromDomain(NewsSource newsSource) {
    return NewsSourceDto(
      sourceName: newsSource.sourceName.getOrCrash(),
    );
  }

  NewsSource toDomain() {
    return NewsSource(
      sourceName: SourceName(sourceName),
    );
  }

  factory NewsSourceDto.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceDtoFromJson(json);
}
