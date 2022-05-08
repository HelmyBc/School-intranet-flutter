import 'dart:convert';

import 'package:enetcom_app/models/user.dart';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student extends User {
  
  // Student({
  //   // required this.id,
  //   // required this.cin,
  //   // required this.firstName,
  //   // required this.lastName,
  //   // required this.email,
  //   // required this.password,
  //   // required this.phone,
  //   // required this.imageUrl,
  //   required this.classeId,
  //   required this.depId,
  //   this.postsId,
  // }) : super(id: id,firstName: firstName);

  // int? id;
  // int? cin;
  // String? firstName;
  // String? lastName;
  // String email;
  // String password;
  // int? phone;
  // String? imageUrl;
  int classeId;
  int depId;
  List? postsId;
  Student({
    required id,
    required cin,
    required firstName,
    required lastName,
    required email,
    required password,
    required phone,
    required imageUrl,
    required this.classeId,
    required this.depId,
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

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        cin: json["cin"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        classeId: json["classeId"],
        depId: json["depId"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        postsId: json["postsId"],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
        "id": id,
        "cin": cin,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "classeId": classeId,
        "depId": depId,
        "phone": phone,
        "imageUrl": imageUrl,
        "postsId": postsId,
      };
  }
}
