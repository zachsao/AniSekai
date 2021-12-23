import 'package:json_annotation/json_annotation.dart';
part 'media.g.dart';

@JsonSerializable()
class Media {
  final int id;
  final Title title;
  final String? bannerImage;
  final CoverImage coverImage;
  final String? description;

  Media(this.id, this.title, this.coverImage, this.bannerImage, this.description);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

@JsonSerializable()
class Title {

  final String? english;
  final String romaji;

  Title(this.english, this.romaji);

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

@JsonSerializable()
class CoverImage {
  final String large;

  CoverImage(this.large);

  factory CoverImage.fromJson(Map<String, dynamic> json) => _$CoverImageFromJson(json);
}