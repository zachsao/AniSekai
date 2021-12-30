import 'package:anisekai/discover/discover_query.dart';

String favouritesQuery = '''
  query {
    Viewer {
      id
      favourites {
        anime {
          nodes {
            ${DiscoverQuery.mediaRequestBody}
          }
        }
      }
    }
  }
''';