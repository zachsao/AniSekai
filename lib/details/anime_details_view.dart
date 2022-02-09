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
import 'package:url_launcher/url_launcher.dart';

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
  bool isDescriptionExpanded = false;

  void _onFavPressed(RunMutation runMutation, Media anime) {
    setState(() {
      isFav = isFav != null ? !isFav! : !anime.isFavourite!;
    });
    runMutation({'animeId': anime.id});
  }

  void _launchStreamingUrl(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return buildQuery(DetailsQuery.query(args.id), (data, _) {
      Media animeDetails = AnimeDetailsModel.fromJson(data).media;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
              child: Text(
                animeDetailsModel.displayTitle(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 16, right: 16),
              child: Container(
                height: 50,
                color: Theme.of(context).colorScheme.secondaryVariant,
                child: Scrollbar(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: buildDetailsBar(animeDetailsModel),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: ExpansionPanelList(
                elevation: 0,
                children: [
                  ExpansionPanel(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryVariant,
                      headerBuilder: (context, isExpanded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              if (!isExpanded)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                      animeDetailsModel.description ?? "",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary)),
                                )
                            ],
                          ),
                        );
                      },
                      body: Html(
                        data: animeDetailsModel.description ?? "",
                        style: {
                          "body": Style(
                              color: Theme.of(context).colorScheme.onSecondary)
                        },
                      ),
                      isExpanded: isDescriptionExpanded,
                      canTapOnHeader: true),
                ],
                expansionCallback: (_, isOpen) {
                  setState(() {
                    isDescriptionExpanded = !isOpen;
                  });
                },
              ),
            ),
            if (animeDetailsModel.streamingEpisodes?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Text(
                  "Watch",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            if (animeDetailsModel.streamingEpisodes?.isNotEmpty == true)
              SizedBox(
                height: 150,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  children: buildStreamingLinksCards(
                      animeDetailsModel.streamingEpisodes!),
                ),
              )
          ],
        ),
      ],
    );
  }

  List<Widget> buildDetailsBar(Media animeDetailsModel) {
    var map = animeDetailsModel.detailsInfo();
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
                  color: key == "Airing"
                      ? Colors.blue
                      : Theme.of(context).colorScheme.onSecondary),
            ),
            Text("$value",
                style: TextStyle(
                    color: key == "Airing"
                        ? Colors.blue
                        : Theme.of(context).colorScheme.onSecondary)),
          ],
        ),
      ));
    });
    return details;
  }

  List<Widget> buildStreamingLinksCards(
      List<StreamingEpisodes> streamingEpisodes) {
    return streamingEpisodes.map((e) {
      return InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text("Continue with browser"),
            titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 20),
            content: Text(
              "You are about to exit Shika to be redirected to ${e.site.toLowerCase()}.com",
              style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () => {_launchStreamingUrl(e.url)},
                child: const Text('OK'),
              )
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                    image: NetworkImage(e.thumbnail),
                    fit: BoxFit.fill,
                    height: 90,
                    width: 90 * 16 / 9),
              ),
              SizedBox(
                width: 90 * 16 / 9,
                child: Text(
                  e.title.split(" - ").first,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }
}

enum ViewingStatus { current, planning, completed, dropped }
