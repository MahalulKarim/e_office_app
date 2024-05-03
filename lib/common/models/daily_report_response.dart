// To parse this JSON data, do
//
//     final dailyReportResponse = dailyReportResponseFromJson(jsonString);

import 'dart:convert';

DailyReportResponse dailyReportResponseFromJson(String str) =>
    DailyReportResponse.fromJson(json.decode(str));

String dailyReportResponseToJson(DailyReportResponse data) =>
    json.encode(data.toJson());

class DailyReportResponse {
  String status;
  DailyReportData data;
  String msg;

  DailyReportResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory DailyReportResponse.fromJson(Map<String, dynamic> json) =>
      DailyReportResponse(
        status: json["status"],
        data: DailyReportData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class DailyReportData {
  List<DailyReport> items;
  int currentPage;
  int totalPages;

  DailyReportData({
    required this.items,
    required this.currentPage,
    required this.totalPages,
  });

  factory DailyReportData.fromJson(Map<String, dynamic> json) =>
      DailyReportData(
        items: List<DailyReport>.from(
            json["items"].map((x) => DailyReport.fromJson(x))),
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}

class DailyReport {
  String id;
  String tgl;
  DateTime tglKunjungan;
  String cityId;
  String namaInstansi;
  String alamatInstansi;
  String telpInstansi;
  String foto;
  String linkVideo;
  String email;
  String atasNama;
  String jabatan;
  String keterangan;
  String lokasi;
  String? status;
  String prioritas;
  String idMarketing;

  DailyReport({
    this.id = '',
    this.tgl = '',
    required this.tglKunjungan,
    this.cityId = '',
    this.namaInstansi = '',
    this.alamatInstansi = '',
    this.telpInstansi = '',
    this.foto = '',
    this.linkVideo = '',
    this.email = '',
    this.atasNama = '',
    this.jabatan = '',
    this.keterangan = '',
    this.lokasi = '',
    this.status,
    this.prioritas = '',
    this.idMarketing = '',
  });

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        id: json["id"],
        tgl: json["tgl"],
        tglKunjungan: DateTime.parse(json["tgl_kunjungan"]),
        cityId: json["city_id"],
        namaInstansi: json["nama_instansi"],
        alamatInstansi: json["alamat_instansi"],
        telpInstansi: json["telp_instansi"],
        foto: json["foto"],
        linkVideo: json["link_video"],
        email: json["email"],
        atasNama: json["atas_nama"],
        jabatan: json["jabatan"],
        keterangan: json["keterangan"],
        lokasi: json["lokasi"],
        status: json["status"],
        prioritas: json["prioritas"],
        idMarketing: json["id_marketing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tgl": tgl,
        "tgl_kunjungan": tglKunjungan.toIso8601String(),
        "city_id": cityId,
        "nama_instansi": namaInstansi,
        "alamat_instansi": alamatInstansi,
        "telp_instansi": telpInstansi,
        "foto": foto,
        "link_video": linkVideo,
        "email": email,
        "atas_nama": atasNama,
        "jabatan": jabatan,
        "keterangan": keterangan,
        "lokasi": lokasi,
        "status": status,
        "prioritas": prioritas,
        "id_marketing": idMarketing,
      };
}
