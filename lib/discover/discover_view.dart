import 'dart:core';

import 'package:anisekai/discover/discover_query.dart';
import 'package:anisekai/discover/discover_state.dart';
import 'package:anisekai/graphql/operations.dart';
import 'package:anisekai/models/media.dart';
import 'package:anisekai/ui/anime_grid_item.dart';
import 'package:anisekai/ui/empty_results_view.dart';
import 'package:flutter/material.dart';

import '../models/discover_model.dart';

enum MediaSeason { WINTER, SPRING, SUMMER, FALL }

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<DiscoverPage> {
  DiscoverUiState _discoverState = DiscoverUiState.initial();
  DateTime today = DateTime.now();

  MediaSeason _season() {
    if (today.month == 12 || today.month <= 2) {
      return MediaSeason.WINTER;
    } else if (today.month >= 3 && today.month <= 5) {
      return MediaSeason.SPRING;
    } else if (today.month >= 6 && today.month <= 8) {
      return MediaSeason.SUMMER;
    } else if (today.month >= 9 && today.month <= 11) {
      return MediaSeason.FALL;
    }
    throw Exception("Unexpected month value");
  }

  MediaSeason _nextSeason() {
    if (_season() == MediaSeason.values.last) {
      return MediaSeason.values.first;
    }
    return MediaSeason.values[MediaSeason.values.indexOf(_season()) + 1];
  }

  int _nextSeasonYear() {
    if (today.month == 12) {
      return today.year + 1;
    }
    return today.year;
  }

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
      myController.clear();
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
          filters["season"] = _season().name;
          filters["seasonYear"] = today.year;
          break;
        case "Upcoming next season":
          filters["sort"] = "POPULARITY_DESC";
          filters["season"] = _nextSeason().name;
          filters["seasonYear"] = _nextSeasonYear();
          break;
        case "All time popular":
          filters["sort"] = "POPULARITY_DESC";
          break;
      }
      _discoverState = DiscoverUiState.fetchingSection(filters);
    });
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: buildDiscoverPage(context, myController),
    );
  }

  Widget buildDiscoverPage(
      BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        searchBar(controller),
        Expanded(
          child: renderUiState(_discoverState),
        )
      ],
    );
  }

  Widget renderUiState(DiscoverUiState state) {
    switch (state.runtimeType) {
      case Initial:
        return buildQuery(DiscoverQuery.sections, (data, _) {
          var sections = [
            buildSection(
                "Trending now", DiscoverModel.fromJson(data).trending.media),
            buildSection("Popular this season",
                DiscoverModel.fromJson(data).currentlyPopular.media),
            buildSection("Upcoming next season",
                DiscoverModel.fromJson(data).upcoming.media),
            buildSection("All time popular",
                DiscoverModel.fromJson(data).allTimePopular.media),
          ];
          return ListView(children: sections);
        }, variables: {
          "season": _season().name,
          "year": today.year,
          "nextSeason": _nextSeason().name,
          "nextSeasonYear": _nextSeasonYear()
        });
      case SearchSubmitted:
        state as SearchSubmitted;
        return buildQuery(DiscoverQuery.search, (data, _) {
          var animes = SearchResultModel.fromJson(data).page.media;
          return animes.isNotEmpty
              ? buildSearchResultsList(animes)
              : const EmptyResults();
        }, variables: {'name': state.text});
      case FetchingSection:
        state as FetchingSection;
        return buildQuery(DiscoverQuery.filter, (data, _) {
          var animes = SearchResultModel.fromJson(data).page.media;
          return animes.isNotEmpty
              ? buildSearchResultsList(animes, filters: state.filters)
              : const Center(
                  child: Text("No results were found."),
                );
        }, variables: state.filters);
    }
    return const Center(child: Text("An error occurred: Invalid state"));
  }

  Widget buildSearchResultsList(List<Media> animes,
      {Map<String, dynamic>? filters}) {
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
          color: Theme.of(context).colorScheme.secondaryVariant,
        ),
        child: Row(
          children: const [
            Text(
              "clear all",
            ),
            Icon(
              Icons.clear,
              size: 18,
            )
          ],
        ),
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
              return AnimeGridItem(
                anime: animes[index],
              );
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {_onViewAllClicked(sectionTitle)},
                    child: const Text("View all"),
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
          return AnimeGridItem(
            anime: animes[index],
          );
        });
  }

  Padding searchBar(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(125),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(125),
            ),
            suffixIcon: IconButton(
              onPressed: _onClearAllPressed,
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.onSecondary.withAlpha(125),
              ),
            ),
            fillColor: Theme.of(context).colorScheme.secondaryVariant,
            filled: true),
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
