import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/exceptions.dart';
import '../../domain/news/i_news_repository.dart';
import '../../domain/news/news.dart';
import '../../domain/news/news_failure.dart';
import '../../extra/network/network_info.dart';
import 'news_remote_datasource.dart';

@LazySingleton(as: INewsRepository)
class NewsRepository implements INewsRepository {
  NewsRepository(
    this._networkInfo,
    this._remoteDataSource,
  );

  final NetworkInfo _networkInfo;
  final INewsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NewsFailure, List<News>>> getNews({
    required int page,
    required int limit,
    String? keyword,
    String? category,
  }) async {
    if (await _networkInfo.isConnected()) {
      try {
        final _listNews = await _remoteDataSource.getNews(
          page: page,
          limit: limit,
          keyword: keyword,
          category: category,
        );
        return right(_listNews);
      } on ServerException {
        return left(const NewsFailure.serverError());
      }
    } else {
      return left(const NewsFailure.noConnectionError());
    }
  }
}
