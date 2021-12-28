
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
  User(this.id);

  final int id;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}