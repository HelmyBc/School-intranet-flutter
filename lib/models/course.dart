import 'dart:convert';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.attachmentId,
  });

  int id;
  String name;
   int subjectId;
   int attachmentId;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        subjectId: json["subjectId"],
        attachmentId: json["attachmentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subjectId": subjectId,
        "attachmentId": attachmentId,
      };
}