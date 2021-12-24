import 'dart:core';

import 'package:anisekai/details/details_arguments.dart';
import 'package:anisekai/discover/discover_query.dart';
import 'package:anisekai/discover/discover_state.dart';
import 'package:anisekai/graphql/query.dart';
import 'package:anisekai/models/media.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/discover_model.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<DiscoverPage> {
  DiscoverUiState _discoverState = DiscoverUiState.initial();

  void _onSearchChanged(String search) {
    setState(() {
      if (search.isNotEmpty) {
        _discoverState = DiscoverUiState.searchSubmitted(search);
      } else {
        _discoverState = DiscoverUiState.initial();
      }
    });
  }

  void _onClearAllPressed() {
    setState(() {
      _discoverState = DiscoverUiState.initial();
    });
  }

  void _onViewAllClicked(String sectionTitle) {
    setState(() {
      Map<String, dynamic> filters = {};
      switch (sectionTitle) {
        case "Trending now":
          filters["sort"] = "TRENDING_DESC";
          break;
        case "Popular this season":
          filters["sort"] = "POPULARITY_DESC";
          filters["season"] = "FALL"; // todo: extract season from date
          filters["seasonYear"] = DateTime.now().year;
          break;
        case "Upcoming this season":
          filters["sort"] = "POPULARITY_DESC";
          filters["season"] = "WINTER";
          filters["seasonYear"] = DateTime.now().year + 1;
          break;
        case "All time popular":
          filters["sort"] = "POPULARITY_DESC";
          break;
      }
      _discoverState = DiscoverUiState.fetchingSection(filters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2B2D42),
      child: buildDiscoverPage(context),
    );
  }

  Widget buildDiscoverPage(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        searchBar(),
        Expanded(
          child: renderUiState(_discoverState),
        )
      ],
    );
  }

  Widget renderUiState(DiscoverUiState state) {
    switch (state.runtimeType) {
      case Initial:
        return buildQuery(DiscoverQuery.sections, context, (data) {
          try {
            var sections = [
              buildSection("Trending now", DiscoverModel.fromJson(data).trending.media),
              buildSection("Popular this season", DiscoverModel.fromJson(data).currentlyPopular.media),
              buildSection("Upcoming this season", DiscoverModel.fromJson(data).upcoming.media),
              buildSection("All time popular", DiscoverModel.fromJson(data).allTimePopular.media),
            ];
            return ListView(children: sections);
          } catch (e) {
            return const Center(child: CircularProgressIndicator());
          }
        });
      case SearchSubmitted:
        state as SearchSubmitted;
        return buildQuery(DiscoverQuery.search, context, (data) {
          try {
            var animes = SearchResultModel.fromJson(data).page.media;
            return animes.isNotEmpty
                ? buildSearchResultsList(animes)
                : const Center(
                    child: Text("No results were found."),
                  );
          } catch(e) {
            return const Center(child: CircularProgressIndicator());
          }
        }, variables: {'name': state.text});
      case FetchingSection:
        state as FetchingSection;
        return buildQuery(DiscoverQuery.filter, context, (data) {
          try {
            var animes = SearchResultModel.fromJson(data).page.media;
            return animes.isNotEmpty
                ? buildSearchResultsList(animes)
                : const Center(
              child: Text("No results were found."),
            );
          } catch(e) {
            return const Center(child: CircularProgressIndicator());
          }
        }, variables: state.filters);
    }
    return const Center(child: Text("An error occurred: Invalid state"));
  }

  Widget buildSearchResultsList(List<Media> animes, {Map<String, dynamic>? filters}) {
    List<Widget> tags = [];
    filters?.forEach((key, value) {
      if (key != "sort") {
        tags.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeData.light().primaryColor,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              value.toString().toLowerCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
      }
    });
    tags.add(TextButton(
      onPressed: _onClearAllPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF393B54),
        ),
        child: Row(children: const [Text("clear all", style: TextStyle(color: Colors.white),), Icon(Icons.clear, color: Colors.white, size: 18,)],),
      ),
    ));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: tags,
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(animes.length, (index) {
              return buildListItem(animes[index]);
            }),
            childAspectRatio: 1 / 1.70,
          ),
        ),
      ],
    );
  }

  Widget buildSection(String sectionTitle, List<Media> animes) {
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
                    onPressed: () => {_onViewAllClicked(sectionTitle)},
                    child: const Text(
                      "View all",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(child: buildSectionList(animes)),
          ],
        ),
      ),
    );
  }

  ListView buildSectionList(List<Media> animes) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: animes.length,
        itemBuilder: (context, index) {
          return buildListItem(animes[index]);
        });
  }

  Widget buildListItem(Media anime) {
    return InkWell(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: FadeInImage.memoryNetwork(
              image: anime.coverImage.large,
              fit: BoxFit.fill,
              width: 100,
              height: 150,
              placeholder: kTransparentImage,
            ),
          ),
          SizedBox(
              width: 100,
              child: Text(
                anime.title.english ?? anime.title.romaji,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: DetailsArguments(anime.id));
      },
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white60),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            fillColor: Color(0xFF393B54),
            filled: true),
        style: const TextStyle(color: Colors.white),
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
