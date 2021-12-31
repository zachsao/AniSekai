String saveMediaListEntryMutation = '''
mutation (\$mediaId: Int, \$status: MediaListStatus) {
  SaveMediaListEntry(mediaId: \$mediaId, status: \$status) {
    status
  }
}
''';

String toggleFavouriteMutation = '''
mutation fav(\$animeId: Int) {
  ToggleFavourite(animeId: \$animeId) {
    anime {
      nodes {
        isFavourite
      }
    }
  }
}
''';
