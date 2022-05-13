import 'dart:convert';

List<Td> tdFromJson(String str) =>
    List<Td>.from(json.decode(str).map((x) => Td.fromJson(x)));

String tdToJson(List<Td> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Td {
  Td({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.attachmentId,
    required this.pdfUrl,
    required this.createdTime,
  });

  int id;
  String name;
   int subjectId;
   int attachmentId;
   String pdfUrl;
   String createdTime;

  factory Td.fromJson(Map<String, dynamic> json) => Td(
        id: json["id"],
        name: json["name"],
        subjectId: json["subjectId"],
        attachmentId: json["attachmentId"],
        pdfUrl: json["pdfUrl"],
        createdTime: json["createdTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subjectId": subjectId,
        "attachmentId": attachmentId,
        "pdfUrl": pdfUrl,
        "createdTime": createdTime,
      };
}
