import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    required this.id,
    required this.cin,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.classeId,
    required this.depId,
    // required this.lastModifiedTime,
    // required this.createdTime,
    // required this.deleted,
  });

  int id;
  int cin;
  String name;
  String email;
  int phone;
  String imageUrl;
  int classeId;
  int depId;
  // DateTime lastModifiedTime;
  // DateTime createdTime;
  // bool deleted;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        cin: json["cin"],
        name: json["name"],
        email: json["email"],
        classeId: json["classeId"],
        depId: json["depId"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        // lastModifiedTime: json["lastModifiedTime"],
        // createdTime: json["createdTime"],
        // deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cin": cin,
        "name": name,
        "email": email,
        "classeId": classeId,
        "depId": depId,
        "phone": phone,
        "imageUrl": imageUrl,
        // "lastModifiedTime": lastModifiedTime,
        // "createdTime": createdTime,
        // "deleted": deleted,
      };
}
