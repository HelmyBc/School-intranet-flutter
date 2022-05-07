import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    required this.id,
    required this.level,
    required this.name,
    this.coursesIds,
    this.tdsIds,
    this.depIds,
  });

  int id;
  int level;
  String name;
  List? coursesIds;
  List? tdsIds;
  List? depIds;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        level: json["level"],
        coursesIds: json["coursesIds"],
        tdsIds: json["tdsIds"],
        depIds: json["depIds"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
        "coursesIds": coursesIds,
        "tdsIds": tdsIds,
        "depIds": depIds,
      };
}
