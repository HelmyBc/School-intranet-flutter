import 'package:enetcom_app/models/teacher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpTeacherService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> updateTeacher(int id, Teacher teacher) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/teacher/$id');

    Map data = {
      "name": teacher.name,
      "email": teacher.email,
      "phone": teacher.phone,
      "cin": teacher.cin,
      "imageUrl": teacher.imageUrl,
      "chefDep": teacher.chefDep,
    };
    var body = json.encode(data);
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> getTeacher(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/teacher/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteTeacher(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/teacher/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<List<Teacher>> fetchTeachers() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/teacher'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return teacherFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Teacher> addTeacher(String name, String email, int cin,
      int phone, String imageUrl, bool chefDep) async {
    Map data = {
      "name": name,
      "email": email,
      "cin": cin,
      "phone": phone,
      "imageUrl": imageUrl,
      "chefDep": chefDep,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/teacher');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Teacher teacher = Teacher.fromJson(responseMap as Map<String, dynamic>);
    return teacher;
  }
}
