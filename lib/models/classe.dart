import 'dart:convert';

import 'package:enetcom_app/models/subject.dart';

List<Classe> classeFromJson(String str) =>
    List<Classe>.from(json.decode(str).map((x) => Classe.fromJson(x)));

String classeToJson(List<Classe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Classe {
  Classe({
    required this.id,
    required this.level,
    required this.groupe,
    required this.depId,
    required this.name,
    this.subjectsId,
  });

  int id;
  int level;
  int groupe;
  int depId;
  String name;
  List? subjectsId;

  factory Classe.fromJson(Map<String, dynamic> json) => Classe(
        id: json["id"],
        name: json["name"],
        level: json["level"],
        groupe: json["groupe"],
        depId: json["depId"],
        subjectsId: json["subjectsId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "level": level,
        "groupe": groupe,
        "depId": depId,
        "subjectsId": subjectsId,
      };
}
