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
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'bannerImage': instance.bannerImage,
      'coverImage': instance.coverImage,
      'description': instance.description,
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
