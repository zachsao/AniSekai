import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/discover/discover_query.dart';
import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/models/media.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/discover_model.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildDiscoverPage(context),
    );
  }

  Widget buildDiscoverPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  fillColor: Color(0xFF393B54),
                  filled: true),
              style: TextStyle(color: Colors.white),
            ),
          ),
          buildQuery(DiscoverQuery.query, context, (data) {
            List<Widget> sections = [
              buildSection("Trending now", DiscoverModel.fromJson(data).trending.media),
              buildSection("Popular this season", DiscoverModel.fromJson(data).currentlyPopular.media),
              buildSection("Upcoming this season", DiscoverModel.fromJson(data).upcoming.media),
              buildSection("All time popular", DiscoverModel.fromJson(data).allTimePopular.media),
            ];

            return Column(
              children: sections,
            );
          })
        ],
      ),
    );
  }

  Padding buildSection(String sectionTitle, List<Media> animes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sectionTitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "View all",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: buildTrendingList(animes)),
          ],
        ),
      ),
    );
  }

  ListView buildTrendingList(List<Media> animes) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: animes.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: FadeInImage.memoryNetwork(
                    image: animes[index].coverImage.large,
                    fit: BoxFit.fill,
                    width: 100,
                    height: 150,
                    placeholder: kTransparentImage,
                  ),
                ),
                SizedBox(
                    width: 100,
                    child: Text(
                      animes[index].title.english ?? animes[index].title.romaji,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: DetailsArguments(animes[index].id));
            },
          );
        });
  }
}
