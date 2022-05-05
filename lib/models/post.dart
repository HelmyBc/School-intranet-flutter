import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  final String description;
  final int uid;
  final String username;
  //final likes;
  final int id;
  final String createdTime;
  final String? imageUrl;
  final int? imageId;
  final String profImage;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    //required this.likes,
    required this.id,
    required this.createdTime,
    required this.imageUrl,
    required this.imageId,
    required this.profImage,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        uid: json["uid"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        imageId: json["imageId"],
        username: json["username"],
        profImage: json["profImage"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "description": description,
        "imageUrl": imageUrl,
        "imageId": imageId,
        "username": username,
        "profImage": profImage,
        "createdTime": createdTime,
      };
}
