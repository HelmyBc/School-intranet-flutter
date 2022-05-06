import 'dart:convert';

List<Teacher> teacherFromJson(String str) =>
    List<Teacher>.from(json.decode(str).map((x) => Teacher.fromJson(x)));

String teacherToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
  Teacher({
    required this.id,
    required this.cin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.imageUrl,
    required this.chefDep,
    required this.depId,
    required this.classesId,
  });

  int id;
  int cin;
  int depId;
  String firstName;
  String lastName;
  String email;
  String password;
  int phone;
  String imageUrl;
  bool chefDep;
  List<int> classesId;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        cin: json["cin"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        chefDep: json["chefDep"],
        depId: json["depId"],
        classesId: json["classesId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cin": cin,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "imageUrl": imageUrl,
        "chefDep": chefDep,
        "depId": depId,
        "classesId": classesId,
      };
}
