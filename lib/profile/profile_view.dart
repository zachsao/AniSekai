import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/models/user.dart';
import 'package:anisekai/profile/profile_query.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: buildProfilePage(context),
    );
  }

  Widget buildProfilePage(BuildContext context) {
    return buildQuery(profileQuery, (data, _) {
      User user = UserModel.fromJson(data).user;
      return ListView(children: [
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4 + 60,
              child: Stack(
                children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: user.bannerImage ??
                        "https://via.placeholder.com/1600x400?text=Banner+unavailable",
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    placeholderCacheHeight:
                        MediaQuery.of(context).size.height ~/ 4,
                    placeholderFit: BoxFit.cover,
                  ),
                  Positioned(
                    left: (MediaQuery.of(context).size.width / 2) - 50,
                    top: MediaQuery.of(context).size.height / 4 - 50,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(user.avatar!.large),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                user.name!,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                user.about ?? "Write something about you",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Statistics",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                color: Theme.of(context).colorScheme.secondaryVariant,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${user.statistics?.anime.count ?? 0}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total animes",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${user.statistics?.anime.episodesWatched ?? 0}",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Episodes watched",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            GenreStatsDonutChart(genres: user.statistics!.anime.genres)
          ],
        ),
      ]);
    });
  }
}

class GenreStatsDonutChart extends StatelessWidget {
  final List<Genre> genres;

  const GenreStatsDonutChart({Key? key, required this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(
        text: "Genre overview",
        alignment: ChartAlignment.near,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      legend: Legend(
          isVisible: true,
          textStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          overflowMode: LegendItemOverflowMode.scroll,
          position: LegendPosition.bottom),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CircularSeries>[
        DoughnutSeries<Genre, String>(
            dataSource: genres,
            xValueMapper: (Genre genre, _) => genre.genre,
            yValueMapper: (Genre genre, _) => genre.count,
            dataLabelSettings:
                const DataLabelSettings(isVisible: true, color: Colors.white),
            enableTooltip: true),
      ],
    );
  }
}
