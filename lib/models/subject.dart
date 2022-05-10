import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    required this.id,
    required this.classeId,
    required this.name,
    required this.teacherName,
    this.coursesIds,
    this.tdsIds,
  });

  int id;
  int classeId;
  String name;
  String teacherName;
  List? coursesIds;
  List? tdsIds;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        teacherName: json["teacherName"],
        classeId: json["classeId"],
        coursesIds: json["coursesIds"],
        tdsIds: json["tdsIds"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "teacherName": teacherName,
        "classeId": classeId,
        "coursesIds": coursesIds,
        "tdsIds": tdsIds,
      };
}
