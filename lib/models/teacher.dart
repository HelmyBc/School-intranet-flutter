import 'dart:convert';

import 'package:enetcom_app/models/user.dart';

List<Teacher> teacherFromJson(String str) =>
    List<Teacher>.from(json.decode(str).map((x) => Teacher.fromJson(x)));

String teacherToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher extends User {
  Teacher({
    required id,
    required cin,
    required firstName,
    required lastName,
    required email,
    required password,
    required phone,
    required imageUrl,
    required this.chefDep,
    required this.depId,
    this.classesId,
    this.postsId,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          cin: cin,
          email: email,
          password: password,
          phone: phone,
          imageUrl: imageUrl,
        );
  // int id;
  // int cin;

  // String firstName;
  // String lastName;
  // String email;
  // String password;
  // int phone;
  // String imageUrl;
  int depId;
  bool chefDep;
  List? classesId;
  List? postsId;

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
        postsId: json["postsId"],
      );

  @override
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
        "postsId": postsId,
      };
}
