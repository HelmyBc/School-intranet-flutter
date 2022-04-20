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

  static Future<Student> addStudent(String name, String email, int cin,
      int phone, String imageUrl, String classe) async {
    Map data = {
      "name": name,
      "email": email,
      "phone": phone,
      "cin": cin,
      "classe": classe,
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

  static Future<http.Response> getStudent(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/student/$id');
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
}
