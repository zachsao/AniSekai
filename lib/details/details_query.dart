class DetailsQuery {
  static String query(int id) {
    return '''
    query {
      Media(id: $id) {
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
      }
    }
  ''';
  }
}