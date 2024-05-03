// To parse this JSON data, do
//
//     final jenisMateriResponse = jenisMateriResponseFromJson(jsonString);

import 'dart:convert';

JenisMateriResponse jenisMateriResponseFromJson(String str) =>
    JenisMateriResponse.fromJson(json.decode(str));

String jenisMateriResponseToJson(JenisMateriResponse data) =>
    json.encode(data.toJson());

class JenisMateriResponse {
  String status;
  List<JenisMateri> data;
  String msg;

  JenisMateriResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory JenisMateriResponse.fromJson(Map<String, dynamic> json) =>
      JenisMateriResponse(
        status: json["status"],
        data: List<JenisMateri>.from(
            json["data"].map((x) => JenisMateri.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class JenisMateri {
  String id;
  String jenisMateri;

  JenisMateri({
    required this.id,
    required this.jenisMateri,
  });

  factory JenisMateri.fromJson(Map<String, dynamic> json) => JenisMateri(
        id: json["id"],
        jenisMateri: json["jenis_materi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jenis_materi": jenisMateri,
      };
}
