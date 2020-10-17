import 'dart:convert';

List<UserListingsModel> userListingsModelFromJson(String str) => List<UserListingsModel>.from(json.decode(str).map((x) => UserListingsModel.fromJson(x)));

String userListingsModelToJson(List<UserListingsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListingsModel {
    UserListingsModel({
        this.jobType,
        this.language,
        this.description,
        this.id,
        this.updatedAt,
        this.createdAt,
        this.v,
        this.owner,
    });

    JobType jobType;
    Language language;
    Description description;
    String id;
    DateTime updatedAt;
    DateTime createdAt;
    int v;
    Owner owner;

    factory UserListingsModel.fromJson(Map<String, dynamic> json) => UserListingsModel(
        jobType: jobTypeValues.map[json["jobType"]],
        language: languageValues.map[json["language"]],
        description: descriptionValues.map[json["description"]],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        owner: json["owner"] == null ? null : ownerValues.map[json["owner"]],
    );

    Map<String, dynamic> toJson() => {
        "jobType": jobTypeValues.reverse[jobType],
        "language": languageValues.reverse[language],
        "description": descriptionValues.reverse[description],
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "owner": owner == null ? null : ownerValues.reverse[owner],
    };
}

enum Description { TUTOR_FOR_ENGLISH, FUNYQWE, EMPTY, FUNYDQWE, I_TEACH_FRENCH }

final descriptionValues = EnumValues({
    "": Description.EMPTY,
    "Funydqwe": Description.FUNYDQWE,
    "Funyqwe": Description.FUNYQWE,
    "I teach French": Description.I_TEACH_FRENCH,
    "Tutor for English": Description.TUTOR_FOR_ENGLISH
});

enum JobType { TUTOR, TUTORING, EMPTY }

final jobTypeValues = EnumValues({
    "": JobType.EMPTY,
    "Tutor": JobType.TUTOR,
    "Tutoring": JobType.TUTORING
});

enum Language { ENGLISH, FRENCH, EMPTY, FRENSCH }

final languageValues = EnumValues({
    "": Language.EMPTY,
    "English": Language.ENGLISH,
    "French": Language.FRENCH,
    "Frensch": Language.FRENSCH
});

enum Owner { THE_5_F7267_A58_D607_A000420675_D, THE_5_F7267_A78_D607_A000420675_E, THE_5_F72_DC19_DA9338000485534_E }

final ownerValues = EnumValues({
    "5f7267a58d607a000420675d": Owner.THE_5_F7267_A58_D607_A000420675_D,
    "5f7267a78d607a000420675e": Owner.THE_5_F7267_A78_D607_A000420675_E,
    "5f72dc19da9338000485534e": Owner.THE_5_F72_DC19_DA9338000485534_E
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
