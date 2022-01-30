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
      color: const Color(0xFF2B2D42),
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
                          border: Border.all(color: Colors.white, width: 3),
                          color: const Color(0xFF2B2D42),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(
                        image: NetworkImage(user.avatar!.large),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
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
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                user.about ?? "Write something about you",
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Statistics",
                  style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                color: const Color(0xFF393B54),
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
                                color: ThemeData.light().primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Total animes",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${user.statistics?.anime.episodesWatched ?? 0}",
                            style: TextStyle(
                                color: ThemeData.light().primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text("Episodes watched",
                              style: TextStyle(color: Colors.grey))
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
              color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 14)),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.scroll,
          textStyle: const TextStyle(color: Colors.white),
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
