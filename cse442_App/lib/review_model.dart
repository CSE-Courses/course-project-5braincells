// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

List<List<Review>> reviewsFromJson(String str) => List<List<Review>>.from(json
    .decode(str)
    .map((x) => List<Review>.from(x.map((x) => Review.fromJson(x)))));

String reviewsToJson(List<List<Review>> data) => json.encode(List<dynamic>.from(
    data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

/*
  Review Model that will hold all necessary data for a single review
*/
class Review {
  Review({
    this.stars,
    this.comment,
    this.id,
    this.updatedAt,
    this.createdAt,
    this.v,
  });

  String stars;
  String comment;
  String id;
  DateTime updatedAt;
  DateTime createdAt;
  int v;

  // Converts JSON review object to Dart review object
  factory Review.fromJson(Map<String, dynamic> json) => Review(
        stars: json["stars"],
        comment: json["comment"],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "stars": stars,
        "comment": comment,
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
      };
}
