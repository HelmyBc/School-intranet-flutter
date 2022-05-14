import 'package:enetcom_app/models/feature.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpFeatureService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<List<Feature>> fetchFeatures() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/feature'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return featureFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Feature> addFeature(
    String description,
    String title,
    String imageUrl,
  ) async {
    Map data = {
      "description": description,
      "title": title,
      "imageUrl": imageUrl,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/feature');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Feature feature = Feature.fromJson(responseMap as Map<String, dynamic>);
    return feature;
  }

  static Future<http.Response> updateFeature(int id, Feature feature) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/feature/$id');

    Map data = {
      "title": feature.title,
      "description": feature.title,
      "imageUrl": feature.imageUrl,
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

  static Future<http.Response> getFeature(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/feature/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteFeature(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/feature/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
