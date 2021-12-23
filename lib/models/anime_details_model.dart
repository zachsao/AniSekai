import 'package:json_annotation/json_annotation.dart';
import 'media.dart';
part 'anime_details_model.g.dart';

@JsonSerializable()
class AnimeDetailsModel {
  @JsonKey(name: "Media")
  final Media media;

  AnimeDetailsModel(this.media);

  factory AnimeDetailsModel.fromJson(Map<String, dynamic> json) => _$AnimeDetailsModelFromJson(json);
}