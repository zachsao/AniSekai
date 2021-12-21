class AnimeQuery {
  static const String trending = r'''
    query {
      Page (page: 1, perPage: 10) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media(sort: TRENDING_DESC) {
          title {
            romaji
          }
          coverImage {
            large
          }
        }
      }
    }
  ''';

  static const String currentlyPopular = r'''
    query {
      Page (page: 1, perPage: 10) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media(sort: POPULARITY_DESC, season: FALL, seasonYear: 2021) {
          title {
            romaji
          }
          coverImage {
            large
          }
        }
      }
    }
  ''';
  static const String upcoming = r'''
    query {
      Page (page: 1, perPage: 10) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media(sort: POPULARITY_DESC, seasonYear: 2022) {
          title {
            romaji
          }
          coverImage {
            large
          }
        }
      }
    }
  ''';
  static const String allTimePopular = r'''
    query {
      Page (page: 1, perPage: 10) {
        pageInfo {
          total
          currentPage
          lastPage
          hasNextPage
          perPage
        }
        media(sort: POPULARITY_DESC) {
          title {
            romaji
          }
          coverImage {
            large
          }
        }
      }
    }
  ''';
}
