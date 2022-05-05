// import 'package:enetcom_app/models/attachment.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HttpPostService {
//   static var client = http.Client();
//   static Map<String, String> headers = {"Content-Type": "application/json"};

//   // static Future<List<Attachment>> fetchAttachments() async {
//   //   var response =
//   //       await client.get(Uri.parse('http://192.168.56.1:9191/api/upload'));
//   //   if (response.statusCode == 200) {
//   //     var jsonString = response.body;
//   //     return attachmentFromJson(jsonString);
//   //   } else {
//   //     //show error message
//   //     return [];
//   //   }
//   // }

//   static Future<Attachment> addAttachment(
//     String description,
//     String username,
//     int uid,
//     int imageId,
//     String imageUrl,
//     String profImage,
//     //DateTime createdTime,
//   ) async {
//     Map data = {
//       "description": description,
//       "uid": uid,
//       "username": username,
//       "imageUrl": imageUrl,
//       "imageId": imageId,
//       "profImage": profImage,
//       //"createdTime": createdTime,
//     };
//     var body = json.encode(data);
//     var url = Uri.parse('http://192.168.56.1:9191/api/upload');

//     http.Response response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );
//     print(response.body);
//     Map responseMap = jsonDecode(response.body);
//     Attachment post = Attachment.fromJson(responseMap as Map<String, dynamic>);
//     return post;
//   }

  

//   static Future<http.Response> getPost(int id) async {
//     var url = Uri.parse('http://192.168.56.1:9191/api/atachment/$id');
//     http.Response response = await http.get(
//       url,
//       headers: headers,
//     );
//     print(response.body);
//     return response;
//   }

  
// }
