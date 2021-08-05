import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../domain/news/news.dart';
import '../../extra/utils/logging.dart';
import 'dto/news_dtos.dart';

abstract class INewsRemoteDataSource {
  Future<List<News>> getNews({
    required int page,
    required int limit,
    String? keyword,
    String? category,
  });
}

@LazySingleton(as: INewsRemoteDataSource)
class NewsRemoteDataSource implements INewsRemoteDataSource {
  NewsRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<News>> getNews({
    required int page,
    required int limit,
    String? keyword,
    String? category,
  }) async {
    try {
      final response = await _dio.get(
        'top-headlines',
        queryParameters: {
          'page': page,
          'pageSize': limit,
          'q': keyword,
          'category': category,
          'country': 'id',
        },
      );

      if (response.statusCode == 200) {
        final listNews = response.data['articles']
            .map((e) => NewsDto.fromJson(e).toDomain())
            .cast<News>()
            .toList();

        return listNews;
      } else {
        throw ServerException();
      }
    } catch (e, s) {
      Log.severe(e.toString());
      Log.severe(s.toString());
      throw ServerException();
    }
  }
}
