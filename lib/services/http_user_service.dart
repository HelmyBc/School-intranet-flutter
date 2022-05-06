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
      String firstName, String lastName, String email, int cin, int phone, String imageUrl) async {
    Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "cin": cin,
      "phone": phone,
      "imageUrl": imageUrl,
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
