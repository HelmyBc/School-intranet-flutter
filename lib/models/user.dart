import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.id,
    required this.cin,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.imageUrl,
    required this.lastModifiedTime,
    required this.createdTime,
    required this.deleted,
  });

  int id;
  int cin;
  String firstName;
  String lastName;
  String email;
  int phone;
  String imageUrl;
  DateTime lastModifiedTime;
  DateTime createdTime;
  bool deleted;
  //list of posts
  //

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        cin: json["cin"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        lastModifiedTime: json["lastModifiedTime"],
        createdTime: json["createdTime"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cin": cin,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "imageUrl": imageUrl,
        "lastModifiedTime": lastModifiedTime,
        "createdTime": createdTime,
        "deleted": deleted,
      };
}
