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
  static const String query = '''
    query {
      trending: Page(page: 1, perPage: 10) {
        media(sort: TRENDING_DESC) {
          $mediaRequestBody
        }
      }
      currentlyPopular: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, season: FALL, seasonYear: 2021, type: ANIME) {
          $mediaRequestBody
        }
      }
      upcoming: Page(page: 1, perPage: 10) {
        media(sort: POPULARITY_DESC, seasonYear: 2022, type: ANIME) {
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
}
