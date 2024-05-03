// To parse this JSON data, do
//
//     final absenMasukResponse = absenMasukResponseFromJson(jsonString);

import 'dart:convert';

AbsenMasukResponse absenMasukResponseFromJson(String str) =>
    AbsenMasukResponse.fromJson(json.decode(str));

String absenMasukResponseToJson(AbsenMasukResponse data) =>
    json.encode(data.toJson());

class AbsenMasukResponse {
  String? status;
  Data? data;
  String? msg;

  AbsenMasukResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory AbsenMasukResponse.fromJson(Map<String, dynamic> json) =>
      AbsenMasukResponse(
        status: json["status"] ?? "",
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : Data(insertId: 0, info: "", late: false),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data != null
            ? data!.toJson()
            : Data(insertId: 0, info: "", late: false),
        "msg": msg,
      };
}

class Data {
  int insertId;
  String info;
  bool late;

  Data({
    required this.insertId,
    required this.info,
    required this.late,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        insertId: json["insert_id"],
        info: json["info"],
        late: json["late"],
      );

  Map<String, dynamic> toJson() => {
        "insert_id": insertId,
        "info": info,
        "late": late,
      };
}
