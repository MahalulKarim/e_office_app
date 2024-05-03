// To parse this JSON data, do
//
//     final penilaianMentorResponse = penilaianMentorResponseFromJson(jsonString);

import 'dart:convert';

PenilaianMentorResponse penilaianMentorResponseFromJson(String str) =>
    PenilaianMentorResponse.fromJson(json.decode(str));

String penilaianMentorResponseToJson(PenilaianMentorResponse data) =>
    json.encode(data.toJson());

class PenilaianMentorResponse {
  String status;
  PenilaianMentorData data;
  String msg;

  PenilaianMentorResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory PenilaianMentorResponse.fromJson(Map<String, dynamic> json) =>
      PenilaianMentorResponse(
        status: json["status"],
        data: PenilaianMentorData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class PenilaianMentorData {
  Meta meta;
  List<PenilaianMentor> items;

  PenilaianMentorData({
    required this.meta,
    required this.items,
  });

  factory PenilaianMentorData.fromJson(Map<String, dynamic> json) =>
      PenilaianMentorData(
        meta: Meta.fromJson(json["meta"]),
        items: List<PenilaianMentor>.from(
            json["items"].map((x) => PenilaianMentor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class PenilaianMentor {
  String id;
  String idUsers;
  String kriteria;
  String nilai;
  DateTime tglPenilaian;
  String gKriteria;
  String gNilai;
  String gLinkRemidi;
  String gNilaiRemidi;
  String namaPegawai;
  String asal;
  String kodeKelas;
  String namaKelas;

  PenilaianMentor({
    required this.id,
    required this.idUsers,
    required this.kriteria,
    required this.nilai,
    required this.tglPenilaian,
    required this.gKriteria,
    required this.gNilai,
    required this.gLinkRemidi,
    required this.gNilaiRemidi,
    required this.namaPegawai,
    required this.asal,
    required this.kodeKelas,
    required this.namaKelas,
  });

  factory PenilaianMentor.fromJson(Map<String, dynamic> json) =>
      PenilaianMentor(
        id: json["id"],
        idUsers: json["id_users"],
        kriteria: json["kriteria"],
        nilai: json["nilai"],
        tglPenilaian: DateTime.parse(json["tgl_penilaian"]),
        gKriteria: json["g_kriteria"],
        gNilai: json["g_nilai"],
        gLinkRemidi: json["g_link_remidi"],
        gNilaiRemidi: json["g_nilai_remidi"],
        namaPegawai: json["nama_pegawai"],
        asal: json["asal"],
        kodeKelas: json["kode_kelas"],
        namaKelas: json["nama_kelas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_users": idUsers,
        "kriteria": kriteria,
        "nilai": nilai,
        "tgl_penilaian":
            "${tglPenilaian.year.toString().padLeft(4, '0')}-${tglPenilaian.month.toString().padLeft(2, '0')}-${tglPenilaian.day.toString().padLeft(2, '0')}",
        "g_kriteria": gKriteria,
        "g_nilai": gNilai,
        "g_link_remidi": gLinkRemidi,
        "g_nilai_remidi": gNilaiRemidi,
        "nama_pegawai": namaPegawai,
        "asal": asal,
        "kode_kelas": kodeKelas,
        "nama_kelas": namaKelas,
      };
}

class Meta {
  int totalPages;
  int limit;
  int currentPage;

  Meta({
    required this.totalPages,
    required this.limit,
    required this.currentPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalPages: json["total_pages"],
        limit: json["limit"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "limit": limit,
        "current_page": currentPage,
      };
}
