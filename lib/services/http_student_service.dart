import 'package:enetcom_app/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpStudentService {
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

  static Future<Student> addStudent(
      String firstName,
      String lastName,
      String email,
      String password,
      int cin,
      int phone,
      String imageUrl,
      int classeId,
      int depId) async {
    Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "cin": cin,
      "classeId": classeId,
      "depId": depId,
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

  static Future<http.Response> updateStudent(int id, Student student) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');

    Map data = {
      "firstName": student.firstName,
      "lastName": student.lastName,
      "email": student.email,
      "phone": student.phone,
      "cin": student.cin,
      "password": student.password,
      "classeId": student.classeId,
      "depId": student.depId,
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

  static Future<Student> getStudent(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      Student student = Student.fromJson(responseMap as Map<String, dynamic>);
      return student;
    } else {
      return null as Student;
    }
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
}
