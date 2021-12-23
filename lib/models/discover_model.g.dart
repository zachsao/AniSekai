// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverModel _$DiscoverModelFromJson(Map<String, dynamic> json) =>
    DiscoverModel(
      page: Page.fromJson(json['Page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscoverModelToJson(DiscoverModel instance) =>
    <String, dynamic>{
      'Page': instance.page,
    };

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      media: (json['media'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'media': instance.media,
    };
