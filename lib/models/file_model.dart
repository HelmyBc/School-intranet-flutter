// class FileModel {
//   List<String> files;
//   String folder;

//   FileModel({required this.files,required this.folder});

//   FileModel.fromJson(Map<String, dynamic> json) {
//     files = json['files'].cast<String>();
//     folder = json['folderName'];
//   }
// }

import 'dart:convert';

List<FileModel> fileModelFromJson(String str) =>
    List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String fileModelToJson(List<FileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  FileModel({required this.files, required this.folder});
  List<String> files;
  String folder;
  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        files: json["files"],
        folder: json["folder"],
      );

  Map<String, dynamic> toJson() => {
        "files": files,
        "folder": folder,
      };
}
