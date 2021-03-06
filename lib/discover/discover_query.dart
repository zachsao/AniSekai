class DiscoverQuery {
  static const String mediaRequestBody = '''
    id
    title {
      english
      romaji
    }
    coverImage {
      large
    }
  ''';
  static const String sections = '''
    query (\$season: MediaSeason, \$year: Int, \$nextSeason: MediaSeason, \$nextSeasonYear: Int) {
      trending: Page(page: 1, perPage: 10) {
        media(sort: TRENDING_DESC, type: ANIME) {
          $mediaRequestBody
        }
      }
      currentlyPopular: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, season: \$season, seasonYear: \$year, type: ANIME) {
          $mediaRequestBody
        }
      }
      upcoming: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, season: \$nextSeason, seasonYear: \$nextSeasonYear, type: ANIME) {
          $mediaRequestBody
        }
      }
      allTimePopular: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, type: ANIME) {
          $mediaRequestBody
        }
      }
    }
  ''';
  static String search = """
    query Search(\$name: String){
      Page(page: 1) {
        media(search: \$name, type: ANIME) {
          $mediaRequestBody
        }
      }
    }
  """;
  static String filter = """
    query Filter(\$sort: [MediaSort], \$season: MediaSeason, \$seasonYear: Int){
      Page(page: 1) {
        media(sort: \$sort, season: \$season, seasonYear: \$seasonYear, type: ANIME) {
          $mediaRequestBody
        }
      }
    }
  """;
}
