import 'package:codebase_project_assignment/feature/user_list/domain/entity/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_list_model.g.dart';

/// User Model (Hive-Compatible & JSON Serializable)
@JsonSerializable()
@HiveType(typeId: 0) // Unique Hive Type ID
class UserData extends UserDataEntity {
  @override
  @HiveField(0)
  final int? id;

  @override
  @HiveField(1)
  final String? email;

  @override
  @HiveField(2)
  @JsonKey(name: 'first_name')
  final String? firstName;

  @override
  @HiveField(3)
  @JsonKey(name: 'last_name')
  final String? lastName;

  @override
  @HiveField(4)
  final String? avatar;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  /// JSON Serialization
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

/// User List Model (Holds List of Users)
@JsonSerializable()
@HiveType(typeId: 1) // Unique Hive Type ID
class UserListModel {
  @HiveField(0)
  final int? page;

  @HiveField(1)
  final int? perPage;

  @HiveField(2)
  final int? total;

  @HiveField(3)
  final int? totalPages;

  @HiveField(4)
  final List<UserData>? data;

  UserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  /// JSON Serialization
  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserListModelToJson(this);
}
