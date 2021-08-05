import 'package:dartz/dartz.dart';

import 'news.dart';
import 'news_failure.dart';

abstract class INewsRepository {
  Future<Either<NewsFailure, List<News>>> getNews({
    required int page,
    required int limit,
    String? keyword,
    String? category,
  });
}
