// To parse this JSON data, do
//
//     final laporanTotalResponse = laporanTotalResponseFromJson(jsonString);

import 'dart:convert';

LaporanTotalResponse laporanTotalResponseFromJson(String str) =>
    LaporanTotalResponse.fromJson(json.decode(str));

String laporanTotalResponseToJson(LaporanTotalResponse data) =>
    json.encode(data.toJson());

class LaporanTotalResponse {
  LaporanTotalResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  LaporanTotal? data;
  String? msg;

  factory LaporanTotalResponse.fromJson(Map<String, dynamic> json) =>
      LaporanTotalResponse(
        status: json["status"] ?? "",
        data: LaporanTotal.fromJson(json["data"] ?? []),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : data!.toJson(),
        "msg": msg,
      };
}

class LaporanTotal {
  LaporanTotal({
    this.periodStart,
    this.periodEnd,
    this.totalPage,
    this.totalMasuk,
    this.totalPulang,
    this.totalIzin,
    this.totalSakit,
    this.totalWfh,
    this.totalTugas,
  });

  String? periodStart;
  String? periodEnd;
  int? totalPage;
  int? totalMasuk;
  int? totalPulang;
  int? totalIzin;
  int? totalSakit;
  int? totalWfh;
  int? totalTugas;

  factory LaporanTotal.fromJson(Map<String, dynamic> json) => LaporanTotal(
        periodStart: json["period_start"] ?? "",
        periodEnd: json["period_end"] ?? "",
        totalPage: json["total_page"] ?? 0,
        totalMasuk: json["total_masuk"] ?? 0,
        totalPulang: json["total_pulang"] ?? 0,
        totalIzin: json["total_izin"] ?? 0,
        totalSakit: json["total_sakit"] ?? 0,
        totalWfh: json["total_wfh"] ?? 0,
        totalTugas: json["total_tugas"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "period_start": periodStart,
        "period_end": periodEnd,
        "total_page": totalPage,
        "total_masuk": totalMasuk,
        "total_pulang": totalPulang,
        "total_izin": totalIzin,
        "total_sakit": totalSakit,
        "total_wfh": totalWfh,
        "total_tugas": totalTugas,
      };
}
