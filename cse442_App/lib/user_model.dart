// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        "lastname": lastname,
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