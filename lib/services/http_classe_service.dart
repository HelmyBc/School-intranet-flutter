import 'package:enetcom_app/models/classe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpClasseService {
  static var client = http.Client();
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static Future<List<Classe>> fetchClasses() async {
    var response =
        await client.get(Uri.parse('http://192.168.56.1:9191/api/classe'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return classeFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }

  static Future<Classe> addClasse(
    int level,
    int groupe,
    int depId,
    String name,
  ) async {
    Map data = {
      "name": name,
      "level": level,
      "groupe": groupe,
      "depId": depId,
    };
    var body = json.encode(data);
    var url = Uri.parse('http://192.168.56.1:9191/api/classe');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Classe classe = Classe.fromJson(responseMap as Map<String, dynamic>);
    return classe;
  }

  static Future<http.Response> updateClasse(int id, Classe classe) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/classe/$id');

    Map data = {
      "name": classe.name,
      "level": classe.level,
      "groupe": classe.groupe,
      "depId": classe.depId,
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

  static Future<Classe> getClasse(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/classe/$id');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    if (response.body != null) {
      Map responseMap = jsonDecode(response.body);
      Classe classe = Classe.fromJson(responseMap as Map<String, dynamic>);
      return classe;
    } else {
      return null as Classe;
    }
  }

  static Future<http.Response> deleteClasse(int id) async {
    var url = Uri.parse('http://192.168.56.1:9191/api/classe/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
