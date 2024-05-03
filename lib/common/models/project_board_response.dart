// To parse this JSON data, do
//
//     final projectBoardDataResponse = projectBoardDataResponseFromJson(jsonString);

import 'dart:convert';

ProjectBoardDataResponse projectBoardDataResponseFromJson(String str) =>
    ProjectBoardDataResponse.fromJson(json.decode(str));

String projectBoardDataResponseToJson(ProjectBoardDataResponse data) =>
    json.encode(data.toJson());

class ProjectBoardDataResponse {
  String? status;
  List<ProjectBoardData> data;
  String? msg;

  ProjectBoardDataResponse({
    this.status,
    required this.data,
    this.msg,
  });

  factory ProjectBoardDataResponse.fromJson(Map<String, dynamic> json) =>
      ProjectBoardDataResponse(
        status: json["status"] ?? "",
        data: List<ProjectBoardData>.from(
            json["data"].map((x) => ProjectBoardData.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ProjectBoardData {
  String? id;
  String? idProject;
  dynamic idMember;
  String? dateCreated;
  String? task;
  dynamic url;
  String? description;
  dynamic attachment;
  String? idStatus;
  dynamic idTicket;
  String? namaOrder;
  String? project;
  dynamic namaMember;
  dynamic email;
  String? name;
  String? status;
  List<String>? name_users_join;

  ProjectBoardData({
    this.id,
    this.idProject,
    this.idMember,
    this.dateCreated,
    this.task,
    this.url,
    this.description,
    this.attachment,
    this.idStatus,
    this.idTicket,
    this.namaOrder,
    this.project,
    this.namaMember,
    this.email,
    this.name,
    this.status,
    this.name_users_join,
  });

  factory ProjectBoardData.fromJson(Map<String, dynamic> json) =>
      ProjectBoardData(
        id: json["id"] ?? "",
        idProject: json["id_project"] ?? "",
        idMember: json["id_member"] ?? "",
        dateCreated: json["date_created"] ?? "",
        task: json["task"] ?? "",
        url: json["url"] ?? "",
        description: json["description"] ?? "",
        attachment: json["attachment"] ?? "",
        idStatus: json["id_status"] ?? "",
        idTicket: json["id_ticket"] ?? "",
        namaOrder: json["nama_order"] ?? "",
        project: json["project"] ?? "",
        namaMember: json["nama_member"] ?? "",
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        status: json["status"] ?? "",
        name_users_join: List<String>.from(json["name_users_join"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_project": idProject,
        "id_member": idMember,
        "date_created": dateCreated,
        "task": task,
        "url": url,
        "description": description,
        "attachment": attachment,
        "id_status": idStatus,
        "id_ticket": idTicket,
        "nama_order": namaOrder,
        "project": project,
        "nama_member": namaMember,
        "email": email,
        "name": name,
        "status": status,
        "name_users_join": name_users_join,
      };
}
