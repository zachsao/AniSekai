import 'package:anisekai/discover/discover_query.dart';

String watchlistQuery = """
  query watchlist(\$userId: Int) {
    MediaListCollection(userId: \$userId, type:ANIME) {
      mediaGroups: lists {
        name
        entries {
          progress
          media {
            ${DiscoverQuery.mediaRequestBody}
          }
        }
      }
    }
  }
""";