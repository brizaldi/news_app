import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/news/news.dart';
import '../../../extra/routes/router.gr.dart';
import '../../../extra/style/style.dart';
import '../../../extra/utils/datetime_helper.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    const _widgetHeight = 90.0;
    final textTheme = Theme.of(context).textTheme;
    final _author = news.publishedAt.getOrCrash().formattedStringWithTime();
    final _sourceName = news.newsSource.sourceName.getOrCrash();

    return GestureDetector(
      onTap: () => _onTap(context),
      child: SizedBox(
        height: _widgetHeight,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: news.imageUrl.value.fold(
                  (_) => 'https://plchldr.co/i/480?text=No%20Image',
                  (value) => value,
                ),
                fit: BoxFit.cover,
                height: _widgetHeight,
                width: _widgetHeight,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      news.title.value.fold((_) => '-', (value) => value),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  news.author.value.fold(
                    (_) => const SizedBox(),
                    (value) => Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText2!.copyWith(
                        color: Palette.dustyGray,
                      ),
                    ),
                  ),
                  Text(
                    '$_author | $_sourceName',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.caption!.copyWith(
                      color: Palette.dustyGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    news.newsUrl.value.fold(
      (_) {},
      (value) => context.router.push(DetailsRoute(url: value)),
    );
  }
}
