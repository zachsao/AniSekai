// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCollection _$UserCollectionFromJson(Map<String, dynamic> json) =>
    UserCollection(
      MediaListCollection.fromJson(
          json['MediaListCollection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCollectionToJson(UserCollection instance) =>
    <String, dynamic>{
      'MediaListCollection': instance.mediaListCollection,
    };

MediaListCollection _$MediaListCollectionFromJson(Map<String, dynamic> json) =>
    MediaListCollection(
      (json['mediaGroups'] as List<dynamic>)
          .map((e) => MediaGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaListCollectionToJson(
        MediaListCollection instance) =>
    <String, dynamic>{
      'mediaGroups': instance.mediaGroups,
    };

MediaGroup _$MediaGroupFromJson(Map<String, dynamic> json) => MediaGroup(
      json['name'] as String,
      (json['entries'] as List<dynamic>)
          .map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MediaGroupToJson(MediaGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'entries': instance.entries,
    };

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      json['progress'] as int,
      Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'progress': instance.progress,
      'media': instance.media,
    };
