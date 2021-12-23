import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/discover/discover_query.dart';
import 'package:anisekai/models/media.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/discover_model.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildDiscoverPage(),
    );
  }

  Widget buildDiscoverPage() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  fillColor: Color(0xFF393B54),
                  filled: true
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          buildQuery(DiscoverQuery.trending),
          buildQuery(DiscoverQuery.currentlyPopular),
          buildQuery(DiscoverQuery.upcoming),
          buildQuery(DiscoverQuery.allTimePopular),
        ],
      ),
    );
  }

  Query buildQuery(String query) {
    return Query(
      options: QueryOptions(document: gql(query)),
      builder: (QueryResult result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        List<Media> animes = DiscoverModel.fromJson(result.data!).page.media;

        String sectionTitle = "";
        switch (query) {
          case DiscoverQuery.trending:
            sectionTitle = "Trending now";
            break;
          case DiscoverQuery.currentlyPopular:
            sectionTitle = "Popular this season";
            break;
          case DiscoverQuery.upcoming:
            sectionTitle = "Upcoming this season";
            break;
          case DiscoverQuery.allTimePopular:
            sectionTitle = "All time popular";
            break;
        }

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
      },
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
                  child: Image(
                    image: NetworkImage(animes[index].coverImage.large),
                    fit: BoxFit.fill,
                    width: 100,
                    height: 150,
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
