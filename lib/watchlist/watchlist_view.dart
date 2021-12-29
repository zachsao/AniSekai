import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/user_collection.dart';
import 'package:anisekai/watchlist/watchlist_query.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
              return buildListItem(context, watchlist[index]);
            }),
            childAspectRatio: 1 / 1.70,
          );
        },
        variables: {"userId": userId},
      ),
    );
  }

  Widget buildListItem(BuildContext context, Media anime) {
    return InkWell(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: FadeInImage.memoryNetwork(
              image: anime.coverImage.large,
              fit: BoxFit.fill,
              width: 100,
              height: 150,
              placeholder: kTransparentImage,
            ),
          ),
          SizedBox(
              width: 100,
              child: Text(
                anime.title.english ?? anime.title.romaji,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: DetailsArguments(anime.id));
      },
    );
  }
}
