// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.firstname,
        this.lastname,
        this.email,
        this.password,
        this.listOfJobs,
        this.location,
        this.phone,
        this.id,
        this.updatedAt,
        this.createdAt,
        this.v,
    });

    String firstname;
    String lastname;
    String email;
    String password;
    List<dynamic> listOfJobs;
    String location;
    String phone;
    String id;
    DateTime updatedAt;
    DateTime createdAt;
    int v;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        listOfJobs: List<dynamic>.from(json["listOfJobs"].map((x) => x)),
        location: json["location"],
        phone: json["phone"],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "email": email,
        "password": password,
        "listOfJobs": List<dynamic>.from(listOfJobs.map((x) => x)),
        "location": location,
        "phone": phone,
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
