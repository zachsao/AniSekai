import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

@JsonSerializable()
class Media {
  final int id;
  final Title title;
  final String? bannerImage;
  final CoverImage coverImage;
  final String? description;
  final NextAiringEpisode? nextAiringEpisode;
  final String? status;
  final String? format;
  final int? duration;
  final StartDate? startDate;
  final String? season;
  final int? seasonYear;
  final int? averageScore;
  final int? popularity;
  final int? favourites;
  final Studios? studios;
  final String? source;
  final List<String>? genres;
  final MediaList? mediaListEntry;
  final bool? isFavourite;
  final int? episodes;
  final List<StreamingEpisodes>? streamingEpisodes;

  Media(
    this.id,
    this.title,
    this.coverImage,
    this.bannerImage,
    this.description,
    this.nextAiringEpisode,
    this.status,
    this.format,
    this.duration,
    this.startDate,
    this.season,
    this.seasonYear,
    this.averageScore,
    this.popularity,
    this.favourites,
    this.studios,
    this.source,
    this.genres,
    this.mediaListEntry,
    this.isFavourite,
    this.episodes,
    this.streamingEpisodes,
  );

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  String displayTitle() => title.english ?? title.romaji;

  Map<String, dynamic> detailsInfo() {
    Map<String, dynamic> map = {};
    var remainingTime =
        Duration(seconds: nextAiringEpisode?.timeUntilAiring ?? 0);
    var hoursRemaining = remainingTime.inHours - (remainingTime.inDays * 24);
    var minutesRemaining =
        remainingTime.inMinutes - (remainingTime.inHours * 60);
    String timeUntilAiring =
        "${remainingTime.inDays}d ${hoursRemaining}h ${minutesRemaining}m";

    var startDateTime = DateTime(
        startDate?.year ?? 0, startDate?.month ?? 1, startDate?.day ?? 1);
    String formattedStartDate = DateFormat(
            "${startDate?.month != null ? "MMM" : ""} ${startDate?.day != null ? "dd" : ""} ${startDate?.year != null ? "yyyy" : "Unknown"}")
        .format(startDateTime);

    List<String>? studioList = studios?.nodes.map((e) => e.name).toList();

    map["Airing"] = nextAiringEpisode != null
        ? "Ep ${nextAiringEpisode?.episode}: $timeUntilAiring"
        : null;
    map["Format"] = format;
    map["Duration"] = duration != null ? "$duration mins" : null;
    map["Status"] = status;
    map["Start date"] =
        startDate?.isNull() == false ? formattedStartDate : null;
    map["Season"] = season != null ? "$season $seasonYear" : null;
    map["AverageScore"] = averageScore;
    map["Popularity"] = (popularity ?? 0) > 0 ? popularity : null;
    map["Favourites"] = (favourites ?? 0) > 0 ? favourites : null;
    map["Studios"] =
        studioList?.isNotEmpty == true ? studioList?.join(", ") : null;
    map["Source"] = source;
    map["Genres"] = genres?.join(", ");

    return map;
  }
}

@JsonSerializable()
class Title {
  final String? english;
  final String romaji;

  Title(this.english, this.romaji);

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

@JsonSerializable()
class CoverImage {
  final String large;

  CoverImage(this.large);

  factory CoverImage.fromJson(Map<String, dynamic> json) =>
      _$CoverImageFromJson(json);
}

@JsonSerializable()
class NextAiringEpisode {
  NextAiringEpisode(this.episode, this.timeUntilAiring);

  final int episode;
  final int timeUntilAiring;

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) =>
      _$NextAiringEpisodeFromJson(json);
}

@JsonSerializable()
class StartDate {
  StartDate(this.year, this.month, this.day);

  final int? year;
  final int? month;
  final int? day;

  factory StartDate.fromJson(Map<String, dynamic> json) =>
      _$StartDateFromJson(json);

  bool isNull() => year == null && month == null && day == null;
}

@JsonSerializable()
class Studios {
  Studios(this.nodes);

  final List<Node> nodes;

  factory Studios.fromJson(Map<String, dynamic> json) =>
      _$StudiosFromJson(json);
}

@JsonSerializable()
class Node {
  Node(this.name);

  final String name;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}

@JsonSerializable()
class MediaList {
  final String status;

  MediaList(this.status);

  factory MediaList.fromJson(Map<String, dynamic> json) =>
      _$MediaListFromJson(json);

  String? viewingStatus() {
    switch (status) {
      case "CURRENT":
        return "Watching";
      case "PLANNING":
        return "Planning";
      case "COMPLETED":
        return "Completed";
    }
  }
}

@JsonSerializable()
class StreamingEpisodes {
  final String title;
  final String thumbnail;
  final String url;
  final String site;

  StreamingEpisodes(this.title, this.thumbnail, this.url, this.site);

  factory StreamingEpisodes.fromJson(Map<String, dynamic> json) =>
      _$StreamingEpisodesFromJson(json);
}
