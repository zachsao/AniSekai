import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/user_collection.dart';
import 'package:anisekai/ui/anime_grid_item.dart';
import 'package:anisekai/watchlist/watchlist_query.dart';
import 'package:flutter/material.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildQuery(
        watchlistQuery,
        (data) {
          List<MediaGroup> mediaGroups = UserCollection.fromJson(data).mediaListCollection.mediaGroups;
          List<Media> watchlist = mediaGroups.firstWhere((element) => element.name == "Planning").entries.map((e) => e.media).toList();
          return GridView.count(
            crossAxisCount: 3,
            children: List.generate(watchlist.length, (index) {
              return AnimeGridItem(anime: watchlist[index]);
            }),
            childAspectRatio: 1 / 1.70,
          );
        },
        variables: {"userId": userId},
      ),
    );
  }
}
