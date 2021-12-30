
import 'package:anisekai/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  UserModel(this.user);

  @JsonKey(name: "Viewer")
  final User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@JsonSerializable()
class User {
  User(this.id, this.favourites);

  final int id;
  final Favourites? favourites;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Favourites {
  Favourites(this.anime);
  final MediaConnection anime;

  factory Favourites.fromJson(Map<String, dynamic> json) => _$FavouritesFromJson(json);
}

@JsonSerializable()
class MediaConnection {
  MediaConnection(this.nodes);

  final List<Media> nodes;

  factory MediaConnection.fromJson(Map<String, dynamic> json) => _$MediaConnectionFromJson(json);
}