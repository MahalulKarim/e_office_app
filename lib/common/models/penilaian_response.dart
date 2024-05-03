// To parse this JSON data, do
//
//     final penilaianResponse = penilaianResponseFromJson(jsonString);

import 'dart:convert';

PenilaianResponse penilaianResponseFromJson(String str) =>
    PenilaianResponse.fromJson(json.decode(str));

String penilaianResponseToJson(PenilaianResponse data) =>
    json.encode(data.toJson());

class PenilaianResponse {
  String? status;
  List<Penilaian>? data;
  String? msg;

  PenilaianResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory PenilaianResponse.fromJson(Map<String, dynamic> json) =>
      PenilaianResponse(
        status: json["status"] ?? "",
        data: List<Penilaian>.from(
            (json["data"] ?? []).map((x) => Penilaian.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "msg": msg,
      };
}

class Penilaian {
  String? id;
  String? idUsers;
  String? kriteria;
  String? nilai;
  String? tglPenilaian;
  String? linkRemidi;
  String? nilaiRemidi;

  Penilaian({
    this.id,
    this.idUsers,
    this.kriteria,
    this.nilai,
    this.tglPenilaian,
    this.linkRemidi,
    this.nilaiRemidi,
  });

  factory Penilaian.fromJson(Map<String, dynamic> json) => Penilaian(
        id: json["id"] ?? "",
        idUsers: json["id_users"] ?? "",
        kriteria: json["kriteria"] ?? "",
        nilai: json["nilai"] ?? "",
        tglPenilaian: json["tgl_penilaian"] ?? "",
        linkRemidi: json["link_remidi"] ?? "",
        nilaiRemidi: json["nilai_remidi"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_users": idUsers,
        "kriteria": kriteria,
        "nilai": nilai,
        "tgl_penilaian": tglPenilaian,
        "link_remidi": linkRemidi,
        "nilai_remidi": nilaiRemidi,
      };
}
