// To parse this JSON data, do
//
//     final kelasResponse = kelasResponseFromJson(jsonString);

import 'dart:convert';

KelasResponse kelasResponseFromJson(String str) =>
    KelasResponse.fromJson(json.decode(str));

String kelasResponseToJson(KelasResponse data) => json.encode(data.toJson());

List<Kelas> kelasFromJson(List<dynamic> data) =>
    List<Kelas>.from(data.map((x) => Kelas.fromJson(x)));

class KelasResponse {
  String? status;
  List<Kelas>? data;
  String? msg;

  KelasResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory KelasResponse.fromJson(Map<String, dynamic> json) => KelasResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Kelas>.from(json["data"]!.map((x) => Kelas.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Kelas {
  String? id;
  String? idPegawaiMentor;
  String? kodeKelas;
  String? createdDate;
  int? countMember;

  Kelas({
    this.id,
    this.idPegawaiMentor,
    this.kodeKelas,
    this.createdDate,
    this.countMember,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
        id: json["id"],
        idPegawaiMentor: json["id_pegawai_mentor"],
        kodeKelas: json["kode_kelas"],
        createdDate: json["created_date"],
        countMember: json["count_member"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pegawai_mentor": idPegawaiMentor,
        "kode_kelas": kodeKelas,
        "created_date": createdDate,
        "count_member": countMember,
      };
}
