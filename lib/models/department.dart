import 'dart:convert';

List<Department> departmentFromJson(String str) =>
    List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
  Department({
    required this.id,
    required this.name,
    required this.shortName,
    // required this.lastModifiedTime,
    //required this.createdTime,
    // required this.deleted,
  });

  int id;
  String name;
  String shortName;
  // DateTime lastModifiedTime;
  //DateTime createdTime = DateTime.now();
  // bool deleted;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        shortName: json["shortName"],
        // lastModifiedTime: json["lastModifiedTime"],
        //createdTime: json["createdTime"],
        // deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortName": shortName,
        // "lastModifiedTime": lastModifiedTime,
        //"createdTime": createdTime,
        // "deleted": deleted,
      };
}
