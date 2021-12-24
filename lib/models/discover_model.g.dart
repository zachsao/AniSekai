// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverModel _$DiscoverModelFromJson(Map<String, dynamic> json) =>
    DiscoverModel(
      trending: Page.fromJson(json['trending'] as Map<String, dynamic>),
      currentlyPopular:
          Page.fromJson(json['currentlyPopular'] as Map<String, dynamic>),
      upcoming: Page.fromJson(json['upcoming'] as Map<String, dynamic>),
      allTimePopular:
          Page.fromJson(json['allTimePopular'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscoverModelToJson(DiscoverModel instance) =>
    <String, dynamic>{
      'trending': instance.trending,
      'currentlyPopular': instance.currentlyPopular,
      'upcoming': instance.upcoming,
      'allTimePopular': instance.allTimePopular,
    };

SearchResultModel _$SearchResultModelFromJson(Map<String, dynamic> json) =>
    SearchResultModel(
      page: Page.fromJson(json['Page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResultModelToJson(SearchResultModel instance) =>
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
