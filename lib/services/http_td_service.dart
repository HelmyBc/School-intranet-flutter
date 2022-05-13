import 'package:enetcom_app/models/td.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpTdService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<http.Response> updateTd(int id, Td td) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/td/$id');

    Map data = {
      "name": td.name,
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

  static Future<http.Response> getTd(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/td/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteTd(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/td/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<List<Td>> fetchTds() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/td'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tdFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Td> addTd(
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
    var url = Uri.parse('http://192.168.56.1:9191/api/td');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Td td = Td.fromJson(responseMap as Map<String, dynamic>);
    return td;
  }
}
