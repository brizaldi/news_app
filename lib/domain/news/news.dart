import 'package:freezed_annotation/freezed_annotation.dart';

import 'news_source.dart';
import 'value_objects.dart';

part 'news.freezed.dart';

@freezed
class News with _$News {
  const factory News({
    required NewsSource newsSource,
    required Author author,
    required Title title,
    required Description description,
    required NewsUrl newsUrl,
    required ImageUrl imageUrl,
    required PublishedAt publishedAt,
    required Content content,
  }) = _News;
}
