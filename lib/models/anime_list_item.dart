class AnimeListItem {
  const AnimeListItem({required this.id, required this.title, required this.coverUrl});

  final int id;
  final String title;
  final String coverUrl;

  static List<AnimeListItem> fromJson(dynamic data) {
    List mediaList = data["Page"]["media"];
    List<AnimeListItem> animes = [];
    for (var data in mediaList) {
      animes.add(AnimeListItem(id: data['id'], title: data['title']['romaji'], coverUrl: data['coverImage']['large']));
    }
    return animes;
  }
}
