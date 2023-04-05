// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      user_id: json['_id'] as String?,
      contact: json['contact'] as String?,
      fullname: json['fullname'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      userId: json['userId'] as int? ?? 0,
      profileImage: json['profileImage'] as String?,
      forgetPassword: json['forgetPassword'] as String?,
      role: json['role'] as String? ?? "User",
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      '_id': instance.user_id,
      'profileImage': instance.profileImage,
      'contact': instance.contact,
      'fullname': instance.fullname,
      'email': instance.email,
      'role': instance.role,
      'username': instance.username,
      'password': instance.password,
      'forgetPassword': instance.forgetPassword,
    };
