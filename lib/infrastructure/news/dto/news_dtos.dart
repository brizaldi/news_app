import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/news/news.dart';
import '../../../domain/news/value_objects.dart';
import 'news_source_dtos.dart';

part 'news_dtos.freezed.dart';
part 'news_dtos.g.dart';

@freezed
class NewsDto with _$NewsDto {
  const factory NewsDto({
    @JsonKey(name: 'source') required NewsSourceDto newsSource,
    String? author,
    required String title,
    String? description,
    @JsonKey(name: 'url') String? newsUrl,
    @JsonKey(name: 'urlToImage') String? imageUrl,
    required String publishedAt,
    String? content,
  }) = _NewsDto;

  const NewsDto._();

  factory NewsDto.fromDomain(News news) {
    return NewsDto(
      newsSource: NewsSourceDto.fromDomain(news.newsSource),
      author: news.author.getOrCrash(),
      title: news.title.getOrCrash(),
      description: news.description.getOrCrash(),
      newsUrl: news.newsUrl.getOrCrash(),
      imageUrl: news.imageUrl.getOrCrash(),
      publishedAt: news.publishedAt.getOrCrash().toIso8601String(),
      content: news.content.getOrCrash(),
    );
  }

  News toDomain() {
    return News(
      newsSource: newsSource.toDomain(),
      author: Author(author ?? ''),
      title: Title(title),
      description: Description(description ?? ''),
      newsUrl: NewsUrl(newsUrl ?? ''),
      imageUrl: ImageUrl(imageUrl ?? ''),
      publishedAt: PublishedAt(publishedAt),
      content: Content(content ?? ''),
    );
  }

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
}
