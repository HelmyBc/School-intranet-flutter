import 'package:enetcom_app/models/subject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpSubjectService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> updateSubject(int id, Subject subject) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/subject/$id');

    Map data = {
      "name": subject.name,
      "teacherName": subject.teacherName,
      "classeId": subject.classeId,
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

  static Future<Subject> getSubject(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/subject/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      Subject subject = Subject.fromJson(responseMap as Map<String, dynamic>);
      return subject;
    } else {
      return null as Subject;
    }
  }

  static Future<http.Response> deleteSubject(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/subject/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<List<Subject>> fetchSubjects() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/subject'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return subjectFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Subject> addSubject(
    String name,
    String teacherName,
    int classeId,
  ) async {
    Map data = {
      "name": name,
      "teacherName": teacherName,
      "classeId": classeId,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/subject');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Subject subject = Subject.fromJson(responseMap as Map<String, dynamic>);
    return subject;
  }
}
