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
    });

    int id;
    int cin;
    String name;
    String email;
    int phone;
    String imageUrl;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        cin: json["cin"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cin": cin,
        "name": name,
        "email": email,
        "phone": phone,
        "imageUrl": imageUrl,
    };
}


