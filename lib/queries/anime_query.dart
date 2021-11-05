class AnimeQuery {
  static String trending = r'''
    query Trending {
      Page (page: 1, perPage: 5) {
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
          nextAiringEpisode {
            episode
          }
        }
      }
    }
  ''';
}
