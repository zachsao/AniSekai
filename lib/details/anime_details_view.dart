import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/details/details_query.dart';
import 'package:anisekai/models/anime_details_model.dart';
import 'package:anisekai/models/media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

import '../graphql/query.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    return buildQuery(
        DetailsQuery.query(args.id),
        context,
        (data) {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / bannerHeightFactor + 50,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: animeDetailsModel.bannerImage ?? "https://via.placeholder.com/1600x400?text=Banner+unavailable",
                  height: MediaQuery.of(context).size.height / bannerHeightFactor,
                  fit: BoxFit.cover,
                  placeholderCacheHeight: MediaQuery.of(context).size.height ~/ bannerHeightFactor,
                  placeholderFit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(shape: const CircleBorder(), backgroundColor: ThemeData.light().primaryColor),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: MediaQuery.of(context).size.height / bannerHeightFactor - 100,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Text("Add to list"),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      animeDetailsModel.title.english ?? animeDetailsModel.title.romaji,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                  ),
                ),
                Container(
                    color: const Color(0xFF393B54),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: animeDetailsModel.description ?? "",
                        style: {
                          "body": Style(
                            color: Colors.white
                          )
                        },
                      ),
                    ),
                  )
                ],
            )
          ),

        ],
      ),
    );
  }
}
