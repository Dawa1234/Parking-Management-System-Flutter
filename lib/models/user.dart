// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'user.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
@Entity()
class User {
  @Id(assignable: true)
  int userId;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? user_id;
  String? profileImage;
  String? contact;
  String? fullname;
  String? email;
  String? role;
  String? username;
  String? password;
  String? forgetPassword;

  User(
      {this.user_id,
      this.contact,
      this.fullname,
      this.email,
      this.username,
      this.password,
      this.userId = 0,
      this.profileImage,
      this.forgetPassword,
      this.role = "User"});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
