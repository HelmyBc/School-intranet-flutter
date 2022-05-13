import 'package:enetcom_app/models/course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpCourseService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> updateCourse(int id, Course course) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/course/$id');

    Map data = {
      "name": course.name,
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

  static Future<http.Response> getCourse(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/course/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteCourse(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/course/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<List<Course>> fetchCourses() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/course'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Course> addCourse(
    String name,
    int subjectId,
    int attachmentId,  
    String pdfUrl,  
  ) async {
    Map data = {
      "name": name,
      "subjectId": subjectId,
      "attachmentId": attachmentId,
      "pdfUrl": pdfUrl,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/course');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Course course = Course.fromJson(responseMap as Map<String, dynamic>);
    return course;
  }
}
