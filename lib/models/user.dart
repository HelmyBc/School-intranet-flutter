import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.cin,
    this.id,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    this.phone,
    this.imageUrl,
    this.userType,
    this.chefDep,
    this.classeId,
    this.classesId,
    this.depId,
    this.postsId,
  });

  int? id;
  int? cin;
  String? firstName;
  String? lastName;
  String email;
  String password;
  int? phone;
  String? imageUrl;
  String? userType;
  //inherited
  bool? chefDep;
  List? classesId;
  int? classeId;
  int? depId;
  List? postsId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        cin: json["cin"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
        userType: json["userType"],
        chefDep: json["chefDep"],
        classesId: json["classesId"],
        classeId: json["classeId"],
        depId: json["depId"],
        postsId: json["postsId"],
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
        "userType": userType,
        "chefDep": chefDep,
        "classesId": classesId,
        "classeId": classeId,
        "depId": depId,
        "postsId": postsId,
      };
}
