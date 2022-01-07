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
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bannerImage': instance.bannerImage,
      'about': instance.about,
      'avatar': instance.avatar,
      'favourites': instance.favourites,
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
