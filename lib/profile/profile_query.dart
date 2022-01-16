String profileQuery = '''
query {
  Viewer {
    id
    name
    bannerImage
    about
    avatar {
      large
    }
    statistics {
      anime {
        count
        episodesWatched
        genres {
          count
          genre
        }
      }
    }
  }
}
''';