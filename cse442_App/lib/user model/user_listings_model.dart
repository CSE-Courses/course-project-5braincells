import 'dart:convert';

List<UserListingsModel> userListingsModelFromJson(String str) =>
    List<UserListingsModel>.from(
        json.decode(str).map((x) => UserListingsModel.fromJson(x)));

String userListingsModelToJson(List<UserListingsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListingsModel {
  UserListingsModel({
    this.jobType,
    this.language,
    this.description,
    this.id,
    this.updatedAt,
    this.createdAt,
    this.v,
    this.distAway,
    this.owner,
  });

  String jobType;
  String language;
  String description;
  String id;
  String distAway;
  DateTime updatedAt;
  DateTime createdAt;
  int v;
  String owner;

  factory UserListingsModel.fromJson(Map<String, dynamic> json) =>
      UserListingsModel(
        jobType: json["jobType"],
        language: json["language"],
        description: json["description"],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        owner: json["owner"] == null ? null : json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "jobType": jobType,
        "language": language,
        "description": description,
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "owner": owner == null ? null : owner,
      };
}
