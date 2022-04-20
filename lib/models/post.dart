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
  final String imageUrl;
  final String profImage;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    //required this.likes,
    required this.id,
    required this.createdTime,
    required this.imageUrl,
    required this.profImage,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        uid: json["uid"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        username: json["username"],
        profImage: json["profImage"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "description": description,
        "imageUrl": imageUrl,
        "username": username,
        "profImage": profImage,
        "createdTime": createdTime,
      };
}
