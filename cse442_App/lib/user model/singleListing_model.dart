// To parse this JSON data, do
//
//     final singleListing = singleListingFromJson(jsonString);

import 'dart:convert';

List<SingleListing> singleListingFromJson(String str) => List<SingleListing>.from(json.decode(str).map((x) => SingleListing.fromJson(x)));

String singleListingToJson(List<SingleListing> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleListing {
    SingleListing({
        this.jobType,
        this.language,
        this.description,
        this.id,
        this.owner,
        this.updatedAt,
        this.createdAt,
        this.v,
    });

    String jobType;
    String language;
    String description;
    String id;
    String owner;
    DateTime updatedAt;
    DateTime createdAt;
    int v;

    factory SingleListing.fromJson(Map<String, dynamic> json) => SingleListing(
        jobType: json["jobType"],
        language: json["language"],
        description: json["description"],
        id: json["_id"],
        owner: json["owner"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "jobType": jobType,
        "language": language,
        "description": description,
        "_id": id,
        "owner": owner,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
    };
}
