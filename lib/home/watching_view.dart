import 'package:anisekai/details/anime_details_view.dart';
import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/home/edit_dialog.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/user_collection.dart';
import 'package:flutter/material.dart';

class WatchingList extends StatelessWidget {
  const WatchingList({Key? key, required this.entries}) : super(key: key);
  final List<Entry> entries;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return buildListItem(context, entries, index);
        });
  }

  int lastAiredEpisode(Media anime) {
    return anime.episodes ?? (anime.nextAiringEpisode?.episode ?? 1) - 1;
  }

  InkWell buildListItem(BuildContext context, List<Entry> entries, int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsPage.routeName,
            arguments: DetailsArguments(entries[index].media.id));
      },
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
                  entries[index].media.displayTitle(),
                  style: const TextStyle(
                      color: Color(0xFF2B2D42),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(
                  entries[index].progress > 0
                      ? "Last watched: Ep ${entries[index].progress}"
                      : "Not started",
                  style: const TextStyle(
                    color: Color(0xFF2B2D42),
                    fontSize: 18,
                  ),
                ),
                if (entries[index].media.detailsInfo()["Airing"] != null)
                  Text(
                    "${entries[index].media.detailsInfo()["Airing"]}",
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
              ],
            ),
            Positioned(
                left: 16, top: 124, child: buildProgress(entries[index])),
            Positioned(
              right: 16,
              top: 140,
              child: ElevatedButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => EditDialog(
                    entryId: entries[index].id,
                    title: entries[index].media.displayTitle(),
                    currentProgress: entries[index].progress,
                    maxProgress: lastAiredEpisode(entries[index].media),
                  ),
                ),
                style: TextButton.styleFrom(shape: const CircleBorder()),
                child: const Icon(Icons.more_horiz),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildProgress(Entry entry) {
    int lastEpisode =
        entry.media.episodes ?? entry.media.nextAiringEpisode?.episode ?? 0;
    double progress = (lastEpisode > 0 ? entry.progress / lastEpisode : 0.0);
    int percentage = (progress * 100).floor();
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1,
            color: Colors.blue.shade100,
          ),
          CircularProgressIndicator(
            value: progress,
            color: Colors.blue,
          ),
          Center(
            child: Text(
              "$percentage%",
              style: const TextStyle(
                  color: Color(0xFF2B2D42),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
