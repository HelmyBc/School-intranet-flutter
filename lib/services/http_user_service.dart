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

  static Future<http.Response> getUser(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/user/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
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
}
