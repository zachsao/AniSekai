import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/home/home_query.dart';
import 'package:anisekai/home/watching_view.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/user_collection.dart';
import 'package:anisekai/ui/anime_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
              tabs: [Text("Watching"), Text("Planning"), Text("Completed")]),
        ),
        body: buildHomePage(context, userId),
      ),
    );
  }

  Widget buildHomePage(BuildContext context, int userId) {
  return Container(
    color: const Color(0xFF2B2D42),
    child: buildQuery(
      homeQuery,
      (data, refetch) {
        List<MediaGroup> mediaGroups =
            UserCollection.fromJson(data).mediaListCollection.mediaGroups;
        List<Entry> watchingEntries = mediaGroups
            .firstWhere((element) => element.name == "Watching",
                orElse: () => MediaGroup("name", []))
            .entries;
        List<Media> completed = mediaGroups
            .firstWhere((element) => element.name == "Completed",
                orElse: () => MediaGroup("name", []))
            .entries
            .map((e) => e.media)
            .toList();
        List<Media> watchlist = mediaGroups
            .firstWhere((element) => element.name == "Planning",
                orElse: () => MediaGroup("name", []))
            .entries
            .map((e) => e.media)
            .toList();
        return TabBarView(children: [
          WatchingList(entries: watchingEntries, refetch: refetch,),
          GridView.count(
            crossAxisCount: 3,
            children: List.generate(watchlist.length, (index) {
              return AnimeGridItem(anime: watchlist[index]);
            }),
            childAspectRatio: 1 / 1.70,
          ),
          GridView.count(
            crossAxisCount: 3,
            children: List.generate(completed.length, (index) {
              return AnimeGridItem(anime: completed[index]);
            }),
            childAspectRatio: 1 / 1.70,
          )
        ]);
      },
      variables: {"userId": userId},
    ),
  );
}
}
