import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/user.dart';
import 'package:anisekai/ui/anime_grid_item.dart';
import 'package:flutter/cupertino.dart';

import 'favourites_query.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildQuery(
        favouritesQuery,
        (data) {
          List<Media> favourites = UserModel.fromJson(data).user.favourites?.anime.nodes ?? [];
          return GridView.count(
            crossAxisCount: 3,
            children: List.generate(favourites.length, (index) {
              return AnimeGridItem(anime: favourites[index]);
            }),
            childAspectRatio: 1 / 1.70,
          );
        },
      ),
    );
  }
}
