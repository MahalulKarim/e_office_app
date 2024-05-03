// To parse this JSON data, do
//
//     final tugasResponse = tugasResponseFromJson(jsonString);

import 'dart:convert';

TugasResponse tugasResponseFromJson(String str) =>
    TugasResponse.fromJson(json.decode(str));

String tugasResponseToJson(TugasResponse data) => json.encode(data.toJson());

class TugasResponse {
  TugasResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  List<Tugas>? data;
  String? msg;

  factory TugasResponse.fromJson(Map<String, dynamic> json) => TugasResponse(
        status: json["status"],
        data: List<Tugas>.from(json["data"].map((x) => Tugas.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Tugas {
  Tugas({
    this.id,
    this.idPegawai,
    this.tgl,
    this.tglTugas,
    this.judul,
    this.tugas,
    this.fileTugas,
    this.tglSelesai,
    this.upload,
    this.selesai,
    this.idProject,
    this.priority,
    this.progress,
    this.jenis,
    this.waktu,
    this.isUpdate,
    this.tanggungan,
    this.uploadTugas,
    this.listUploadTugas,
  });

  String? id;
  String? idPegawai;
  String? tgl;
  String? tglTugas;
  String? judul;
  String? tugas;
  String? fileTugas;
  String? tglSelesai;
  String? upload;
  String? selesai;
  String? idProject;
  String? priority;
  dynamic progress;
  dynamic jenis;
  int? waktu;
  String? isUpdate;
  String? tanggungan;
  String? uploadTugas;
  List<ListUploadTugas>? listUploadTugas;

  factory Tugas.fromJson(Map<String, dynamic> json) => Tugas(
        id: json["id"] ?? "",
        idPegawai: json["id_pegawai"] ?? "",
        tgl: json["tgl"] ?? "",
        tglTugas: json["tgl_tugas"] ?? "",
        judul: json["judul"] ?? "",
        tugas: json["tugas"] ?? "",
        fileTugas: json["file_tugas"] ?? "",
        tglSelesai: json["tgl_selesai"] ?? "",
        upload: json["upload"] ?? "",
        selesai: json["selesai"] ?? "",
        idProject: json["id_project"] ?? "",
        priority: json["priority"] ?? "",
        progress: json["progress"] ?? "",
        jenis: json["jenis"] ?? "",
        waktu: json["waktu"] != null
            ? (json["waktu"] is int)
                ? json["waktu"]
                : int.parse(json["waktu"])
            : 1,
        isUpdate: json["is_update"] ?? "",
        tanggungan: json["tanggungan"] ?? "",
        uploadTugas: json["upload_tugas"] ?? "",
        listUploadTugas: List<ListUploadTugas>.from(
          (json["list_upload_tugas"] ?? []).map(
            (x) => ListUploadTugas.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai": idPegawai,
        "tgl": tgl,
        "tgl_tugas": tglTugas,
        "judul": judul,
        "tugas": tugas,
        "file_tugas": fileTugas,
        "tgl_selesai": tglSelesai,
        "upload": upload,
        "selesai": selesai,
        "id_project": idProject,
        "priority": priority,
        "progress": progress,
        "jenis": jenis,
        "waktu": waktu,
        "is_update": isUpdate,
        "tanggungan": tanggungan,
        "upload_tugas": uploadTugas,
        "list_upload_tugas":
            List<dynamic>.from((listUploadTugas ?? []).map((x) => x.toJson())),
      };
}

class ListUploadTugas {
  ListUploadTugas({
    this.id,
    this.idTugas,
    this.idPegawai,
    this.tgl,
    this.ket,
    this.file,
    this.waktu,
    this.urlFile,
  });

  String? id;
  String? idTugas;
  String? idPegawai;
  String? tgl;
  String? ket;
  String? file;
  String? waktu;
  String? urlFile;

  factory ListUploadTugas.fromJson(Map<String, dynamic> json) =>
      ListUploadTugas(
        id: json["id"] ?? "",
        idTugas: json["id_tugas"] ?? "",
        idPegawai: json["id_pegawai"] ?? "",
        tgl: json["tgl"] ?? "",
        ket: json["ket"] ?? "",
        file: json["file"] ?? "",
        waktu: json["waktu"] ?? "",
        urlFile: json["url_file"] ?? "",
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
      };
}
