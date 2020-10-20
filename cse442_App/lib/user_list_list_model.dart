import 'dart:convert';

List<List<UserList>> userListFromJson(String str) =>
    List<List<UserList>>.from(json
        .decode(str)
        .map((x) => List<UserList>.from(x.map((x) => UserList.fromJson(x)))));

String userListToJson(List<List<UserList>> data) =>
    json.encode(List<dynamic>.from(
        data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class UserList {
  UserList({
    this.jobType,
    this.language,
    this.description,
    this.id,
    this.updatedAt,
    this.createdAt,
    this.v,
  });

  String jobType;
  String language;
  String description;
  String id;
  DateTime updatedAt;
  DateTime createdAt;
  int v;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        jobType: json["jobType"],
        language: json["language"],
        description: json["description"],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "jobType": jobType,
        "language": language,
        "description": description,
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
