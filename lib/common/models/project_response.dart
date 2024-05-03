// To parse this JSON data, do
//
//     final projectBoardDataResponse = projectBoardDataResponseFromJson(jsonString);

import 'dart:convert';

ProjectDataResponse projectDataResponseFromJson(String str) =>
    ProjectDataResponse.fromJson(json.decode(str));




String projectDataResponseToJson(ProjectDataResponse data) =>
    json.encode(data.toJson());

class ProjectDataResponse {
  String? status;
  List<ProjectData> data;
  String? msg;

  ProjectDataResponse({
    this.status,
    required this.data,
    this.msg,
  });

  factory ProjectDataResponse.fromJson(Map<String, dynamic> json) =>
      ProjectDataResponse(
        status: json["status"] ?? "",
        data: List<ProjectData>.from(
            json["data"].map((x) => ProjectData.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ProjectData {
  String? id;
  String? project;
  String? description;

  ProjectData({
    this.id,
    this.project,
    this.description,
  });

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
        id: json["id"] ?? "",
        project: json["project"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project": project,
        "description": description,
      };
}

