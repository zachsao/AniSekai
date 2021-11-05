class AnimeListItem {
  const AnimeListItem(
      {required this.title, required this.coverUrl, this.nextEpisode});

  final String title;
  final String coverUrl;
  final String? nextEpisode;

  static List<AnimeListItem> getAnimesFromJson(dynamic data) {
    List mediaList = data["Page"]["media"];
    List<AnimeListItem> animes = [];
    for (var data in mediaList) {
      animes.add(
          AnimeListItem(
              title: data['title']['romaji'],
              coverUrl: data['coverImage']['large'],
              nextEpisode: "${data?['nextAiringEpisode']?['episode'] ?? "none"}")
      );
    }
    return animes;
  }
}
