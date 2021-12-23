// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeDetailsModel _$AnimeDetailsModelFromJson(Map<String, dynamic> json) =>
    AnimeDetailsModel(
      Media.fromJson(json['Media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeDetailsModelToJson(AnimeDetailsModel instance) =>
    <String, dynamic>{
      'Media': instance.media,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      Title.fromJson(json['title'] as Map<String, dynamic>),
      CoverImage.fromJson(json['coverImage'] as Map<String, dynamic>),
      json['bannerImage'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'title': instance.title,
      'bannerImage': instance.bannerImage,
      'coverImage': instance.coverImage,
      'description': instance.description,
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title(
      json['english'] as String,
    );

Map<String, dynamic> _$TitleToJson(Title instance) => <String, dynamic>{
      'english': instance.english,
    };

CoverImage _$CoverImageFromJson(Map<String, dynamic> json) => CoverImage(
      json['large'] as String,
    );

Map<String, dynamic> _$CoverImageToJson(CoverImage instance) =>
    <String, dynamic>{
      'large': instance.large,
    };
