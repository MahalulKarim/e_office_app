// To parse this JSON data, do
//
//     final kelasMemberResponse = kelasMemberResponseFromJson(jsonString);

import 'dart:convert';

KelasMemberResponse kelasMemberResponseFromJson(String str) =>
    KelasMemberResponse.fromJson(json.decode(str));

String kelasMemberResponseToJson(KelasMemberResponse data) =>
    json.encode(data.toJson());

List<KelasMember> kelasMemberFromJson(List<dynamic> data) =>
    List<KelasMember>.from(data.map((x) => KelasMember.fromJson(x)));

class KelasMemberResponse {
  String? status;
  Data? data;
  String? msg;

  KelasMemberResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory KelasMemberResponse.fromJson(Map<String, dynamic> json) =>
      KelasMemberResponse(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "msg": msg,
      };
}

class Data {
  Meta? meta;
  List<KelasMember>? items;

  Data({
    this.meta,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        items: json["items"] == null
            ? []
            : List<KelasMember>.from(
                json["items"]!.map((x) => KelasMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class KelasMember {
  String? id;
  String? idKelasMentor;
  String? idPegawaiTraining;
  String? namaPegawai;
  String? asal;
  String? foto;
  String? createdDate;

  KelasMember({
    this.id,
    this.idKelasMentor,
    this.idPegawaiTraining,
    this.namaPegawai,
    this.asal,
    this.foto,
    this.createdDate,
  });

  factory KelasMember.fromJson(Map<String, dynamic> json) => KelasMember(
        id: json["id"],
        idKelasMentor: json["id_kelas_mentor"],
        idPegawaiTraining: json["id_pegawai_training"],
        namaPegawai: json["nama_pegawai"],
        asal: json["asal"],
        foto: json["foto"],
        createdDate: json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kelas_mentor": idKelasMentor,
        "id_pegawai_training": idPegawaiTraining,
        "nama_pegawai": namaPegawai,
        "asal": asal,
        "foto": foto,
        "created_date": createdDate,
      };

  @override
  String toString() => namaPegawai!;
}

class Meta {
  int? currentPage;
  int? totalPages;
  int? limit;

  Meta({
    this.currentPage,
    this.totalPages,
    this.limit,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "limit": limit,
      };
}
