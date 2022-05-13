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
    required this.pdfUrl,
    required this.attachmentId,
    required this.createdTime,
  });

  int id;
  String name;
  String pdfUrl;
  int subjectId;
  int attachmentId;
  String createdTime;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        subjectId: json["subjectId"],
        attachmentId: json["attachmentId"],
        createdTime: json["createdTime"],
        pdfUrl: json["pdfUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subjectId": subjectId,
        "attachmentId": attachmentId,
        "createdTime": createdTime,
        "pdfUrl": pdfUrl,
      };
}
