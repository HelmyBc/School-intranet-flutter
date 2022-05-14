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

  Feature({
    required this.description,
    required this.title,
    required this.id,
    required this.createdTime,
    required this.imageUrl,
    required this.lastModifiedTime,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        title: json["title"],
         createdTime: json["createdTime"],
         lastModifiedTime: json["lastModifiedTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
         "createdTime": createdTime,
        "lastModifiedTime": lastModifiedTime,
      };
}
