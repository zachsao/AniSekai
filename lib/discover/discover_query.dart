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
    query {
      trending: Page(page: 1, perPage: 10) {
        media(sort: TRENDING_DESC, type: ANIME) {
          $mediaRequestBody
        }
      }
      currentlyPopular: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, season: FALL, seasonYear: 2021, type: ANIME) {
          $mediaRequestBody
        }
      }
      upcoming: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, season: WINTER, seasonYear: 2022, type: ANIME) {
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
}
