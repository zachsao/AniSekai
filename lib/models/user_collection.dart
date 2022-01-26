import 'package:json_annotation/json_annotation.dart';

import 'media.dart';
part 'user_collection.g.dart';

@JsonSerializable()
class UserCollection {
  UserCollection(
    this.mediaListCollection,
  );

  @JsonKey(name: "MediaListCollection")
  final MediaListCollection mediaListCollection;

  factory UserCollection.fromJson(Map<String, dynamic> json) => _$UserCollectionFromJson(json);

}

@JsonSerializable()
class MediaListCollection {
  MediaListCollection(
    this.mediaGroups,
  );

  final List<MediaGroup> mediaGroups;

  factory MediaListCollection.fromJson(Map<String, dynamic> json) => _$MediaListCollectionFromJson(json);
}

@JsonSerializable()
class MediaGroup {
  MediaGroup(
    this.name,
    this.entries,
  );

  final String name;
  final List<Entry> entries;

  factory MediaGroup.fromJson(Map<String, dynamic> json) => _$MediaGroupFromJson(json);

}

@JsonSerializable()
class Entry {
  Entry(
    this.id,
    this.progress,
    this.media,
  );

  final int id;
  final int progress;
  final Media media;

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

}