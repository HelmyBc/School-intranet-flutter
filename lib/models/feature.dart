import 'dart:convert';

List<Feature> featureFromJson(String str) =>
    List<Feature>.from(json.decode(str).map((x) => Feature.fromJson(x)));

String featureToJson(List<Feature> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Feature {
  final String description;
  final String title;
  final int id;
  final String createdTime;
  final String lastModifiedTime;
  final String imageUrl;
  // DateTime createdTime;
  // int id;
  // String title;
  // String description;
  // String imageUrl;
  // DateTime lastModifiedTime;

  Feature({
    required this.description,
    required this.title,
    required this.id,
    required this.createdTime,
    required this.imageUrl,
    required this.lastModifiedTime,
    // required this.id,
    // required this.title,
    // required this.description,
    // required this.imageUrl,
    // required this.lastModifiedTime,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        title: json["title"],
         createdTime: json["createdTime"],
         lastModifiedTime: json["lastModifiedTime"],
        // createdTime: DateTime.parse(json["createdTime"]),
        // id: json["id"],
        // title: json["title"],
        // description: json["description"],
        // imageUrl: json["imageUrl"],
        // lastModifiedTime: DateTime.parse(json["lastModifiedTime"]),
      );
  // factory Feature.fromJson(Map<String, dynamic> json) => Feature(
  //       id: json["id"] == null ? null : json["id"],
  //       title: json["title"] == null ? null : json["title"],
  //       description: json["description"] == null ? null : json["description"],
  //       imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
         "createdTime": createdTime,
        "lastModifiedTime": lastModifiedTime,
      };
}
