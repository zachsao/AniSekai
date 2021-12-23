import 'package:anisekai/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discover_model.g.dart';

@JsonSerializable()
class DiscoverModel {
  const DiscoverModel({required this.trending, required this.currentlyPopular, required this.upcoming, required this.allTimePopular});

  final Page trending;
  final Page currentlyPopular;
  final Page upcoming;
  final Page allTimePopular;

  factory DiscoverModel.fromJson(Map<String, dynamic> json) => _$DiscoverModelFromJson(json);
}

@JsonSerializable()
class Page {
  const Page({required this.media});

  final List<Media> media;

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
}
