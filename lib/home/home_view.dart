import 'package:anisekai/details/anime_details_view.dart';
import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/home/home_query.dart';
import 'package:anisekai/models/user_collection.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(fontSize: 36.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(tabs: [
            Text("WATCHING", style: TextStyle(color: Colors.white, fontSize: 18)),
            Text("COMPLETED", style: TextStyle(color: Colors.white, fontSize: 18))
          ]),
        ),
        body: buildHomePage(context, userId),
      ),
    );
  }
}

Widget buildHomePage(BuildContext context, int userId) {
  return Container(
    color: const Color(0xFF2B2D42),
    child: buildQuery(
      homeQuery,
      (data) {
        List<MediaGroup> mediaGroups = UserCollection.fromJson(data).mediaListCollection.mediaGroups;
        List<Entry> watchingEntries = mediaGroups.firstWhere((element) => element.name == "Watching").entries;
        List<Entry> completedEntries = mediaGroups.firstWhere((element) => element.name == "Completed").entries;
        return TabBarView(children: [
          ListView.builder(
              itemCount: watchingEntries.length,
              itemBuilder: (context, index) {
                return buildListItem(context, watchingEntries, index);
              }),
          ListView.builder(
              itemCount: completedEntries.length,
              itemBuilder: (context, index) {
                return buildListItem(context, completedEntries, index);
              })
        ]);
      },
      variables: {"userId": userId},
    ),
  );
}

InkWell buildListItem(BuildContext context, List<Entry> entries, int index) {
  return InkWell(
    onTap: () { Navigator.pushNamed(context, DetailsPage.routeName, arguments: DetailsArguments(entries[index].media.id)); },
    child: Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Stack(fit: StackFit.expand, children: [
          Image(
            image: NetworkImage(entries[index].media.coverImage.large),
            fit: BoxFit.cover,
            color: const Color.fromRGBO(255, 255, 255, 0.3),
            colorBlendMode: BlendMode.modulate,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                entries[index].media.title.english ?? entries[index].media.title.romaji,
                style: const TextStyle(color: Color(0xFF2B2D42), fontSize: 24, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text("Episode: ${entries[index].progress}", style: const TextStyle(color: Color(0xFF2B2D42), fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
        ]),
      ),
    ),
  );
}
