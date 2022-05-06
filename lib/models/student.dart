import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    required this.id,
    required this.cin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.imageUrl,
    required this.classeId,
    required this.depId,
  });

  int id;
  int cin;
  String firstName;
  String lastName;
  String email;
  String password;
  int phone;
  String imageUrl;
  int classeId;
  int depId;

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
      );

  Map<String, dynamic> toJson() => {
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
      };
}
