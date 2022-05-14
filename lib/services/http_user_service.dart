import 'package:enetcom_app/models/classe.dart';
import 'package:enetcom_app/models/course.dart';
import 'package:enetcom_app/models/post.dart';
import 'package:enetcom_app/models/subject.dart';
import 'package:enetcom_app/models/td.dart';
import 'package:enetcom_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpUserService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> updateUser(int id, User user) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/user/$id');

    Map data = {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "email": user.email,
      "password": user.password,
      "phone": user.phone,
      "cin": user.cin,
      "imageUrl": user.imageUrl,
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

  static Future<User> login(User user) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/user/login');

    Map data = {
      "email": user.email,
      "password": user.password,
    };
    var body = json.encode(data);
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      User user = User.fromJson(responseMap as Map<String, dynamic>);
      return user;
    } else {
      return user;
    }
  }

  static Future<User> getUser(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/user/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      User user = User.fromJson(responseMap as Map<String, dynamic>);
      return user;
    } else {
      return null as User;
    }
  }

  static Future<http.Response> deleteUser(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/user/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

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

  static Future<User> addUser(
    String firstName,
    String lastName,
    String email,
    String password,
    int cin,
    int phone,
    String imageUrl,
    String userType,
  ) async {
    Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "cin": cin,
      "phone": phone,
      "imageUrl": imageUrl,
      "userType": userType,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/user');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    User user = User.fromJson(responseMap as Map<String, dynamic>);
    return user;
  }

  static Future<List<Subject>> fetchUserSubjects(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/user/$id/subjects'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return subjectFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<List<Post>> fetchUserPosts(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/user/$id/posts'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Classe> fetchUserClasse(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/user/$id/classe'));
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      Classe classe = Classe.fromJson(responseMap as Map<String, dynamic>);
      return classe;
    } else {
      return null as Classe;
    }
  }

  static Future<List<Classe>> fetchUserClasses(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/user/$id/classes'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return classeFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<List<Subject>> fetchUserClasseSubjects(int id, int id1) async {
    var response = await client.get(Uri.parse(
        'http://192.168.56.1:9191/api/user/$id/classes/$id1/subjects'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return subjectFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<List<Course>> fetchSubjectCourses(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/subject/$id/courses'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return courseFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<List<Td>> fetchSubjectTds(int id) async {
    var response = await client
        .get(Uri.parse('http://192.168.56.1:9191/api/subject/$id/tds'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tdFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }
}
