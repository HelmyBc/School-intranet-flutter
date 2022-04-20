import 'package:enetcom_app/models/department.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpDepartmentService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<List<User>> fetchUsers() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/user'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return userFromJson(jsonString);
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

  static Future<http.Response> getDepartment(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/department/$id');
    http.Response response = await http.get(
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
}
