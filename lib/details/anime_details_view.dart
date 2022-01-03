import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/details/details_query.dart';
import 'package:anisekai/models/anime_details_model.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/models/save_medialist_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:graphql_flutter/src/widgets/mutation.dart';
import 'package:transparent_image/transparent_image.dart';

import '../graphql/operations.dart';
import 'details_mutation.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = "/details";

  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool? isFav;

  void _onFavPressed(RunMutation runMutation, Media anime) {
    setState(() {
      isFav = isFav != null ? !isFav! : !anime.isFavourite!;
    });
    runMutation({'animeId': anime.id});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return buildQuery(DetailsQuery.query(args.id), (data) {
      Media animeDetails = AnimeDetailsModel.fromJson(data).media;
      return Scaffold(
        backgroundColor: const Color(0xFF2B2D42),
        body: SafeArea(
          child: buildDetailsPage(context, animeDetails),
        ),
      );
    });
  }

  Widget buildDetailsPage(BuildContext context, Media animeDetailsModel) {
    const int bannerHeightFactor = 4;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height / bannerHeightFactor + 50,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: animeDetailsModel.bannerImage ??
                    "https://via.placeholder.com/1600x400?text=Banner+unavailable",
                height: MediaQuery.of(context).size.height / bannerHeightFactor,
                fit: BoxFit.cover,
                placeholderCacheHeight:
                    MediaQuery.of(context).size.height ~/ bannerHeightFactor,
                placeholderFit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: ThemeData.light().primaryColor),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: MediaQuery.of(context).size.height / bannerHeightFactor -
                    100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: NetworkImage(animeDetailsModel.coverImage.large),
                    fit: BoxFit.fill,
                    height: 150,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / bannerHeightFactor,
                left: 116,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: Row(
                    children: [
                      buildMutation(saveMediaListEntryMutation,
                          (data, runMutation) {
                        String status = data != null
                            ? SaveMediaListEntryModel.fromJson(data)
                                    .entry
                                    .viewingStatus() ??
                                "Add to list"
                            : animeDetailsModel.mediaListEntry
                                    ?.viewingStatus() ??
                                "Add to list";
                        return PopupMenuButton<ViewingStatus>(
                          onSelected: (ViewingStatus result) {
                            runMutation({
                              'status': result.name.toUpperCase(),
                              'mediaId': animeDetailsModel.id
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuItem<ViewingStatus>> items = [];
                            for (var element in ViewingStatus.values) {
                              String name = (element.name == "current")
                                  ? "Watching"
                                  : element.name;
                              items.add(PopupMenuItem(
                                child: Text(name),
                                value: element,
                              ));
                            }
                            return items;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ThemeData.light().primaryColor,
                            ),
                            child: Row(
                              children: [
                                Text(status,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white))
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        );
                      }),
                      buildMutation(toggleFavouriteMutation,
                          (data, runMutation) {
                        bool fav =
                            isFav ?? animeDetailsModel.isFavourite ?? false;
                        return IconButton(
                            onPressed: () {
                              _onFavPressed(runMutation, animeDetailsModel);
                            },
                            icon: Icon(
                              fav ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ));
                      })
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    animeDetailsModel.title.english ??
                        animeDetailsModel.title.romaji,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 50,
                    color: const Color(0xFF393B54),
                    child: Scrollbar(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buildDetailsBar(animeDetailsModel),
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: const Color(0xFF393B54),
                  child: Html(
                    data: animeDetailsModel.description ?? "",
                    style: {"body": Style(color: Colors.white)},
                  ),
                )
              ],
            )),
      ],
    );
  }

  List<Widget> buildDetailsBar(Media animeDetailsModel) {
    var map = animeDetailsModel.detailsBarItems();
    map.removeWhere((key, value) => value == null);
    List<Widget> details = [];
    map.forEach((key, value) {
      details.add(Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: key == "Airing" ? Colors.blue : Colors.white),
            ),
            Text("$value",
                style: TextStyle(
                    color: key == "Airing" ? Colors.blue : Colors.white)),
          ],
        ),
      ));
    });
    return details;
  }
}

enum ViewingStatus { current, planning, completed, dropped }
