import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/models/student.dart';
import 'package:enetcom_app/models/teacher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<List<Student>> fetchStudents() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/student'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return studentFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<List<Department>> fetchDepartments() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/department'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return departmentFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Student> addStudent(
      String name, String email, int cin, int phone, String imageUrl) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "cin": cin,
      "imageUrl": imageUrl,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/student');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Student student = Student.fromJson(responseMap as Map<String, dynamic>);
    return student;
  }

  static Future<Department> addDepartment(
    String name,
    String shortName,
  ) async {
    Map data = {
      "name": name,
      "shortName": shortName,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/department');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Department department =
        Department.fromJson(responseMap as Map<String, dynamic>);
    return department;
  }

  static Future<http.Response> updateStudent(int id, Student student) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');

    Map data = {
      "name": student.name,
      "email": student.email,
      "phone": student.phone,
      "cin": student.cin,
      "imageUrl": student.imageUrl,
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

  static Future<http.Response> updateDepartment(
      int id, Department department) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/department/$id');

    Map data = {
      "name": department.name,
      "shortName": department.shortName,
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

  static Future<http.Response> updateTeacher(int id, Teacher teacher) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/teacher/$id');

    Map data = {
      "name": teacher.name,
      "email": teacher.email,
      "phone": teacher.phone,
      "cin": teacher.cin,
      "imageUrl": teacher.imageUrl,
      "chefDep": teacher.chefDep
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

  static Future<http.Response> getStudent(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> getDepartment(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/department/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
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

  static Future<http.Response> deleteStudent(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
  static Future<http.Response> deleteDepartment(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/department/$id');
    http.Response response = await http.delete(
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
