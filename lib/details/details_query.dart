class DetailsQuery {
  static String query(int id) {
    return '''
    query {
      Media(id: $id) {
        isFavourite
        mediaListEntry {
          status
        }
        id
        description
        title {
          romaji
          english
        }
        bannerImage
        coverImage {
          large
        }
        nextAiringEpisode {
          episode
          timeUntilAiring
        }
        status
        format
        duration
        startDate {
          year
          month
          day
        }
        season
        seasonYear
        averageScore
        popularity
        favourites
        studios {
          nodes {
            name
          }
        }
        source
        genres
      }
    }
  ''';
  }
}