import 'dart:convert';

List<Attachment> attachmentFromJson(String str) =>
    List<Attachment>.from(json.decode(str).map((x) => Attachment.fromJson(x)));

String attachmentToJson(List<Attachment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Attachment {
  final int id;
  final String fileName;
  final String fileType;

  const Attachment({
    required this.id,
    required this.fileName,
    required this.fileType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        fileName: json["fileName"],
        fileType: json["fileType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fileName": fileName,
        "fileType": fileType,
      };
}
