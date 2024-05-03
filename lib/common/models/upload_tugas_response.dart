// To parse this JSON data, do
//
//     final uploadTugasResponse = uploadTugasResponseFromJson(jsonString);

import 'dart:convert';

UploadTugasResponse uploadTugasResponseFromJson(String str) =>
    UploadTugasResponse.fromJson(json.decode(str));

String uploadTugasResponseToJson(UploadTugasResponse data) =>
    json.encode(data.toJson());

class UploadTugasResponse {
  String? status;
  UploadTugas? data;
  String? msg;

  UploadTugasResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory UploadTugasResponse.fromJson(Map<String, dynamic> json) =>
      UploadTugasResponse(
        status: json["status"] ?? "",
        data: UploadTugas.fromJson(json["data"] ?? []),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": (data ?? UploadTugas()).toJson(),
        "msg": msg,
      };
}

class UploadTugas {
  String? id;
  String? idTugas;
  String? idPegawai;
  String? tgl;
  String? ket;
  String? file;
  String? waktu;
  String? urlFile;
  String? judul;
  String? tugas;
  String? progress;

  UploadTugas({
    this.id,
    this.idTugas,
    this.idPegawai,
    this.tgl,
    this.ket,
    this.file,
    this.waktu,
    this.urlFile,
    this.judul,
    this.tugas,
    this.progress,
  });

  factory UploadTugas.fromJson(Map<String, dynamic> json) => UploadTugas(
        id: json["id"] ?? "",
        idTugas: json["id_tugas"] ?? "",
        idPegawai: json["id_pegawai"] ?? "",
        tgl: json["tgl"] ?? "",
        ket: json["ket"] ?? "",
        file: json["file"] ?? "",
        waktu: json["waktu"] ?? "",
        urlFile: json["url_file"] ?? "",
        judul: json["judul"] ?? "",
        tugas: json["tugas"] ?? "",
        progress: json["progress"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tugas": idTugas,
        "id_pegawai": idPegawai,
        "tgl": tgl,
        "ket": ket,
        "file": file,
        "waktu": waktu,
        "url_file": urlFile,
        "judul": judul,
        "tugas": tugas,
        "progress": progress,
      };
}
