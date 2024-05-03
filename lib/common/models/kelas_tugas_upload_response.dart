// To parse this JSON data, do
//
//     final kelasTugasUploadResponse = kelasTugasUploadResponseFromJson(jsonString);

import 'dart:convert';

KelasTugasUploadResponse kelasTugasUploadResponseFromJson(String str) => KelasTugasUploadResponse.fromJson(json.decode(str));

String kelasTugasUploadResponseToJson(KelasTugasUploadResponse data) => json.encode(data.toJson());

List<KelasTugasUpload> kelasTugasUploadFromJson(List<dynamic> data) =>
    List<KelasTugasUpload>.from(data.map((x) => KelasTugasUpload.fromJson(x)));

class KelasTugasUploadResponse {
    String? status;
    Data? data;
    String? msg;

    KelasTugasUploadResponse({
        this.status,
        this.data,
        this.msg,
    });

    factory KelasTugasUploadResponse.fromJson(Map<String, dynamic> json) => KelasTugasUploadResponse(
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
    List<KelasTugasUpload>? items;

    Data({
        this.meta,
        this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        items: json["items"] == null ? [] : List<KelasTugasUpload>.from(json["items"]!.map((x) => KelasTugasUpload.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class KelasTugasUpload {
    String? id;
    String? idKelasTugas;
    String? idPegawaiTraining;
    dynamic file;
    String? fileType;
    dynamic keterangan;
    dynamic createdDate;
    String? namaPegawai;

    KelasTugasUpload({
        this.id,
        this.idKelasTugas,
        this.idPegawaiTraining,
        this.file,
        this.fileType,
        this.keterangan,
        this.createdDate,
        this.namaPegawai,
    });

    factory KelasTugasUpload.fromJson(Map<String, dynamic> json) => KelasTugasUpload(
        id: json["id"],
        idKelasTugas: json["id_kelas_tugas"],
        idPegawaiTraining: json["id_pegawai_training"],
        file: json["file"],
        fileType: json["file_type"],
        keterangan: json["keterangan"],
        createdDate: json["created_date"],
        namaPegawai: json["nama_pegawai"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_kelas_tugas": idKelasTugas,
        "id_pegawai_training": idPegawaiTraining,
        "file": file,
        "file_type": fileType,
        "keterangan": keterangan,
        "created_date": createdDate,
        "nama_pegawai": namaPegawai,
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
