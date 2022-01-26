import 'package:anisekai/discover/discover_query.dart';

String homeQuery = """
  query home(\$userId: Int) {
    MediaListCollection(userId: \$userId, type:ANIME) {
      mediaGroups: lists {
        name
        entries {
          id
          progress
          media {
            ${DiscoverQuery.mediaRequestBody}
            nextAiringEpisode {
              episode
              timeUntilAiring
            }
            episodes
          }
        }
      }
    }
  }
""";