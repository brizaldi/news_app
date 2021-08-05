import 'package:freezed_annotation/freezed_annotation.dart';

import 'value_objects.dart';

part 'news_source.freezed.dart';

@freezed
class NewsSource with _$NewsSource {
  const factory NewsSource({
    required SourceName sourceName,
  }) = _NewsSource;
}
