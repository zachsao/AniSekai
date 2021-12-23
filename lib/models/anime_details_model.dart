import 'package:json_annotation/json_annotation.dart';
part 'anime_details_model.g.dart';

@JsonSerializable()
class AnimeDetailsModel {
  @JsonKey(name: "Media")
  final Media media;

  AnimeDetailsModel(this.media);

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) => _$AnimeDetailsModelFromJson(json);
}

@JsonSerializable()
class Media {
  final Title title;
  final String bannerImage;
  final CoverImage coverImage;
  final String description;

  Media(this.title, this.coverImage, this.bannerImage, this.description);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
}

@JsonSerializable()
class Title {
  final String english;

  Title(this.english);

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

@JsonSerializable()
class CoverImage {
  final String large;

  CoverImage(this.large);

  factory CoverImage.fromJson(Map<String, dynamic> json) => _$CoverImageFromJson(json);
}