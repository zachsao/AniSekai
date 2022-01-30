// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      json['id'] as int,
      Title.fromJson(json['title'] as Map<String, dynamic>),
      CoverImage.fromJson(json['coverImage'] as Map<String, dynamic>),
      json['bannerImage'] as String?,
      json['description'] as String?,
      json['nextAiringEpisode'] == null
          ? null
          : NextAiringEpisode.fromJson(
              json['nextAiringEpisode'] as Map<String, dynamic>),
      json['status'] as String?,
      json['format'] as String?,
      json['duration'] as int?,
      json['startDate'] == null
          ? null
          : StartDate.fromJson(json['startDate'] as Map<String, dynamic>),
      json['season'] as String?,
      json['seasonYear'] as int?,
      json['averageScore'] as int?,
      json['popularity'] as int?,
      json['favourites'] as int?,
      json['studios'] == null
          ? null
          : Studios.fromJson(json['studios'] as Map<String, dynamic>),
      json['source'] as String?,
      (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['mediaListEntry'] == null
          ? null
          : MediaList.fromJson(json['mediaListEntry'] as Map<String, dynamic>),
      json['isFavourite'] as bool?,
      json['episodes'] as int?,
      (json['streamingEpisodes'] as List<dynamic>?)
          ?.map((e) => StreamingEpisodes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'bannerImage': instance.bannerImage,
      'coverImage': instance.coverImage,
      'description': instance.description,
      'nextAiringEpisode': instance.nextAiringEpisode,
      'status': instance.status,
      'format': instance.format,
      'duration': instance.duration,
      'startDate': instance.startDate,
      'season': instance.season,
      'seasonYear': instance.seasonYear,
      'averageScore': instance.averageScore,
      'popularity': instance.popularity,
      'favourites': instance.favourites,
      'studios': instance.studios,
      'source': instance.source,
      'genres': instance.genres,
      'mediaListEntry': instance.mediaListEntry,
      'isFavourite': instance.isFavourite,
      'episodes': instance.episodes,
      'streamingEpisodes': instance.streamingEpisodes,
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title(
      json['english'] as String?,
      json['romaji'] as String,
    );

Map<String, dynamic> _$TitleToJson(Title instance) => <String, dynamic>{
      'english': instance.english,
      'romaji': instance.romaji,
    };

CoverImage _$CoverImageFromJson(Map<String, dynamic> json) => CoverImage(
      json['large'] as String,
    );

Map<String, dynamic> _$CoverImageToJson(CoverImage instance) =>
    <String, dynamic>{
      'large': instance.large,
    };

NextAiringEpisode _$NextAiringEpisodeFromJson(Map<String, dynamic> json) =>
    NextAiringEpisode(
      json['episode'] as int,
      json['timeUntilAiring'] as int,
    );

Map<String, dynamic> _$NextAiringEpisodeToJson(NextAiringEpisode instance) =>
    <String, dynamic>{
      'episode': instance.episode,
      'timeUntilAiring': instance.timeUntilAiring,
    };

StartDate _$StartDateFromJson(Map<String, dynamic> json) => StartDate(
      json['year'] as int?,
      json['month'] as int?,
      json['day'] as int?,
    );

Map<String, dynamic> _$StartDateToJson(StartDate instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
    };

Studios _$StudiosFromJson(Map<String, dynamic> json) => Studios(
      (json['nodes'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudiosToJson(Studios instance) => <String, dynamic>{
      'nodes': instance.nodes,
    };

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      json['name'] as String,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'name': instance.name,
    };

MediaList _$MediaListFromJson(Map<String, dynamic> json) => MediaList(
      json['status'] as String,
    );

Map<String, dynamic> _$MediaListToJson(MediaList instance) => <String, dynamic>{
      'status': instance.status,
    };

StreamingEpisodes _$StreamingEpisodesFromJson(Map<String, dynamic> json) =>
    StreamingEpisodes(
      json['title'] as String,
      json['thumbnail'] as String,
      json['url'] as String,
      json['site'] as String,
    );

Map<String, dynamic> _$StreamingEpisodesToJson(StreamingEpisodes instance) =>
    <String, dynamic>{
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'url': instance.url,
      'site': instance.site,
    };
