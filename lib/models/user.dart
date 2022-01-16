
import 'package:anisekai/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  UserModel(this.user);

  @JsonKey(name: "Viewer")
  final User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@JsonSerializable()
class User {
  User(this.id, this.name, this.bannerImage, this.about, this.avatar, this.favourites, this.statistics);

  final int id;
  final String? name;
  final String? bannerImage;
  final String? about;
  final CoverImage? avatar;
  final Favourites? favourites;
  final Statistics? statistics;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Favourites {
  Favourites(this.anime);
  final MediaConnection anime;

  factory Favourites.fromJson(Map<String, dynamic> json) => _$FavouritesFromJson(json);
}

@JsonSerializable()
class MediaConnection {
  MediaConnection(this.nodes);

  final List<Media> nodes;

  factory MediaConnection.fromJson(Map<String, dynamic> json) => _$MediaConnectionFromJson(json);
}

@JsonSerializable()
class Statistics {
    Statistics(this.anime);

    Anime anime;

    factory Statistics.fromJson(Map<String, dynamic> json) => _$StatisticsFromJson(json);
}

@JsonSerializable()
class Anime {
    Anime(
        this.count,
        this.episodesWatched,
        this.genres,
    );

    int count;
    int episodesWatched;
    List<Genre> genres;

    factory Anime.fromJson(Map<String, dynamic> json) => _$AnimeFromJson(json);
}

@JsonSerializable()
class Genre {
    Genre(
        this.count,
        this.genre,
    );

    int count;
    String genre;

    factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
