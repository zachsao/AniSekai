class AnimeListItem {
  const AnimeListItem({required this.title, required this.coverUrl});

  final String title;
  final String coverUrl;

  static List<AnimeListItem> getAnimesFromJson(dynamic data) {
    List mediaList = data["Page"]["media"];
    List<AnimeListItem> animes = [];
    for (var data in mediaList) {
      animes.add(
          AnimeListItem(
          title: data['title']['romaji'],
          coverUrl: data['coverImage']['large']));
    }
    return animes;
  }
}
