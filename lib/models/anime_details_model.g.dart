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
