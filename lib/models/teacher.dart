import 'dart:convert';

List<Teacher> teacherFromJson(String str) =>
    List<Teacher>.from(json.decode(str).map((x) => Teacher.fromJson(x)));

String teacherToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
  Teacher({
    required this.teacherId,
    required this.cin,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.chefDep,
  });

  int teacherId;
  int cin;
  String name;
  String email;
  int phone;
  String imageUrl;
  bool chefDep;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        teacherId: json["teacherId"],
        cin: json["cin"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        chefDep: json["chefDep"],
      );

  Map<String, dynamic> toJson() => {
        "teacherId": teacherId,
        "cin": cin,
        "name": name,
        "email": email,
        "phone": phone,
        "imageUrl": imageUrl,
        "chefDep": chefDep,
      };
}
