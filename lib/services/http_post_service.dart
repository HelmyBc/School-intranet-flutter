import 'package:enetcom_app/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpPostService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<List<Post>> fetchPosts() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/post'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Post> addPost(
    String description,
    String username,
    int uid,
    String imageUrl,
    int imageId,
    String profImage,
    //DateTime createdTime,
  ) async {
    Map data = {
      "description": description,
      "uid": uid,
      "username": username,
      "imageUrl": imageUrl,
      "imageId": imageId,
      "profImage": profImage,
      //"createdTime": createdTime,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/post');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Post post = Post.fromJson(responseMap as Map<String, dynamic>);
    return post;
  }

  static Future<http.Response> updatePost(int id, Post post) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/post/$id');

    Map data = {
      "description": post.description,
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

  static Future<http.Response> getPost(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/post/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deletePost(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/post/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
