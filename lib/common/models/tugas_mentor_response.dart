// To parse this JSON data, do
//
//     final tugasMentorResponse = tugasMentorResponseFromJson(jsonString);

import 'dart:convert';

TugasMentorResponse tugasMentorResponseFromJson(String str) =>
    TugasMentorResponse.fromJson(json.decode(str));

String tugasMentorResponseToJson(TugasMentorResponse data) =>
    json.encode(data.toJson());

List<TugasMentor> tugasMentorFromJson(List<dynamic> data) =>
    List<TugasMentor>.from(data.map((x) => TugasMentor.fromJson(x)));

class TugasMentorResponse {
  String? status;
  Data? data;
  String? msg;

  TugasMentorResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory TugasMentorResponse.fromJson(Map<String, dynamic> json) =>
      TugasMentorResponse(
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
  List<TugasMentor>? items;

  Data({
    this.meta,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        items: json["items"] == null
            ? []
            : List<TugasMentor>.from(
                json["items"]!.map((x) => TugasMentor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class TugasMentor {
  String? kodeKelas;
  String? id;
  String? idKelasMentor;
  String? title;
  String? tugas;
  String? file;
  String? fileType;
  String? createdDate;
  String? createdBy;
  String? expiredDate;
  int? countSubmit;

  TugasMentor({
    this.kodeKelas,
    this.id,
    this.idKelasMentor,
    this.title,
    this.tugas,
    this.file,
    this.fileType,
    this.createdDate,
    this.createdBy,
    this.expiredDate,
    this.countSubmit
  });

  factory TugasMentor.fromJson(Map<String, dynamic> json) => TugasMentor(
        kodeKelas: json["kode_kelas"],
        id: json["id"],
        idKelasMentor: json["id_kelas_mentor"],
        title: json["title"],
        tugas: json["tugas"],
        file: json["file"],
        fileType: json["file_type"],
        createdDate: json["created_date"],
        createdBy: json["created_by"],
        expiredDate: json["expired_date"],
        countSubmit: json["count_submit"]
      );

  Map<String, dynamic> toJson() => {
        "kode_kelas": kodeKelas,
        "id": id,
        "id_kelas_mentor": idKelasMentor,
        "title": title,
        "tugas": tugas,
        "file": file,
        "file_type": fileType,
        "created_date": createdDate,
        "created_by": createdBy,
        "expired_date": expiredDate,
        "count_submit": countSubmit
      };
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
