// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      User.fromJson(json['Viewer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'Viewer': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['name'] as String?,
      json['bannerImage'] as String?,
      json['about'] as String?,
      json['avatar'] == null
          ? null
          : CoverImage.fromJson(json['avatar'] as Map<String, dynamic>),
      json['favourites'] == null
          ? null
          : Favourites.fromJson(json['favourites'] as Map<String, dynamic>),
      json['statistics'] == null
          ? null
          : Statistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bannerImage': instance.bannerImage,
      'about': instance.about,
      'avatar': instance.avatar,
      'favourites': instance.favourites,
      'statistics': instance.statistics,
    };

Favourites _$FavouritesFromJson(Map<String, dynamic> json) => Favourites(
      MediaConnection.fromJson(json['anime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavouritesToJson(Favourites instance) =>
    <String, dynamic>{
      'anime': instance.anime,
    };

MediaConnection _$MediaConnectionFromJson(Map<String, dynamic> json) =>
    MediaConnection(
      (json['nodes'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaConnectionToJson(MediaConnection instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
    };

Statistics _$StatisticsFromJson(Map<String, dynamic> json) => Statistics(
      Anime.fromJson(json['anime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'anime': instance.anime,
    };

Anime _$AnimeFromJson(Map<String, dynamic> json) => Anime(
      json['count'] as int,
      json['episodesWatched'] as int,
      (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeToJson(Anime instance) => <String, dynamic>{
      'count': instance.count,
      'episodesWatched': instance.episodesWatched,
      'genres': instance.genres,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      json['count'] as int,
      json['genre'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'count': instance.count,
      'genre': instance.genre,
    };
