import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/models/anime_details_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailsArguments;

    String detailsQuery = '''
    query {
      Media(id: ${args.id}) {
        description
        title {
          english
        }
        bannerImage
        coverImage {
          large
        }
      }
    }
  ''';
    return buildQuery(detailsQuery, context);
  }

  Query buildQuery(String query, BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(query)),
      builder: (
        QueryResult result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        AnimeDetailsModel animeDetails = AnimeDetailsModel.fromJson(result.data!);

        return Scaffold(
          backgroundColor: const Color(0xFF2B2D42),
          body: buildDetailsPage(context, animeDetails),
        );
      },
    );
  }

  Widget buildDetailsPage(BuildContext context, AnimeDetailsModel animeDetailsModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3 + 50,
              child: Stack(children: [
                Image(
                  image: NetworkImage(animeDetailsModel.media.bannerImage),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 3,
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                  colorBlendMode: BlendMode.modulate,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(shape: const CircleBorder(), backgroundColor: const Color(0xFF347DEA)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: MediaQuery.of(context).size.height / 3 - 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: NetworkImage(animeDetailsModel.media.coverImage.large),
                      fit: BoxFit.fill,
                      height: 150,
                      width: 100,
                    ),
                  ),
                ),
                Positioned(
                    top: MediaQuery.of(context).size.height / 3,
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
                      animeDetailsModel.media.title.english,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFF393B54),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(animeDetailsModel.media.description, style: const TextStyle(color: Colors.white),),
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
