// To parse this JSON data, do
//
//     final laporanTotalResponse = laporanTotalResponseFromJson(jsonString);

import 'dart:convert';

InfoUserAbsenResponse infoUserAbsenResponseFromJson(String str) =>
    InfoUserAbsenResponse.fromJson(json.decode(str));

String infoUserAbsenResponseToJson(InfoUserAbsenResponse data) =>
    json.encode(data.toJson());

class InfoUserAbsenResponse {
  InfoUserAbsenResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  InfoUser? data;
  String? msg;

  factory InfoUserAbsenResponse.fromJson(Map<String, dynamic> json) =>
      InfoUserAbsenResponse(
        status: json["status"] ?? "",
        data: InfoUser.fromJson(json["data"] ?? []),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : data!.toJson(),
        "msg": msg,
      };
}

class InfoUser {
  InfoUser({
    this.greeting,
    this.isMonitor,
    this.textStatusWfh,
    this.textTotalJamKerja,
    this.strTime,
    this.strDateYmd,
    this.tugasPagi,
    this.tugasSiang,
    this.totalTugasPagi,
    this.totalTugasSiang,
    this.status,
    this.infoFalseGps,
    this.isWfh,
    this.statusTidakMasuk,
    this.totalTanggungan,
    this.isSaturday,
    this.certificate,
    this.certificateUrl,
    this.penilaian,
    this.hybrid,
    this.wfh,
    this.officeLatitude,
    this.officeLongitude,
    this.officeMaxDistance,
  });

  String? greeting;
  bool? isMonitor;
  String? textStatusWfh;
  String? textTotalJamKerja;
  String? strTime;
  String? strDateYmd;
  int? tugasPagi;
  int? tugasSiang;
  int? totalTugasPagi;
  int? totalTugasSiang;
  int? status;
  String? infoFalseGps;
  int? isWfh;
  int? statusTidakMasuk;
  int? totalTanggungan;
  int? isSaturday;
  int? certificate;
  String? certificateUrl;
  int? penilaian;
  int? hybrid;
  int? wfh;
  double? officeLatitude;
  double? officeLongitude;
  int? officeMaxDistance;

  factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(
        greeting: json["greeting"] ?? "",
        isMonitor: json["is_monitor"] ?? false,
        textStatusWfh: json["text_status_wfh"] ?? "",
        textTotalJamKerja: json["text_total_jam_kerja"] ?? "",
        strTime: json["str_time"] ?? "",
        strDateYmd: json["str_date_ymd"] ?? "",
        tugasPagi: json["tugas_pagi"] ?? 0,
        tugasSiang: json["tugas_siang"] ?? 0,
        totalTugasPagi: json["total_tugas_pagi"] ?? 0,
        totalTugasSiang: json["total_tugas_siang"] ?? 0,
        status: json["status"] ?? 0,
        infoFalseGps: json["info_false_gps"] ?? "",
        isWfh: json["is_wfh"] ?? 0,
        statusTidakMasuk: json["status_tidak_masuk"] ?? 0,
        totalTanggungan: json["total_tanggungan"] ?? 0,
        isSaturday: json["is_saturday"] ?? 0,
        certificate: json["certificate"] ?? 0,
        certificateUrl: json["certificate_url"] ?? "",
        penilaian: json["penilaian"] ?? 0,
        hybrid: json["hybrid"] is int
            ? json["hybrid"]
            : int.parse(json["hybrid"] ?? "0"),
        wfh: json["wfh"] is int ? json["wfh"] : int.parse(json["wfh"] ?? "0"),
        officeLatitude: json["office_latitude"] ?? 0,
        officeLongitude: json["office_longitude"] ?? 0,
        officeMaxDistance: json["office_max_distance"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "greeting": greeting,
        "is_monitor": isMonitor,
        "text_status_wfh": textStatusWfh,
        "text_total_jam_kerja": textTotalJamKerja,
        "str_time": strTime,
        "str_date_ymd": strDateYmd,
        "tugas_pagi": tugasPagi,
        "tugas_siang": tugasSiang,
        "total_tugas_pagi": totalTugasPagi,
        "total_tugas_siang": totalTugasSiang,
        "status": status,
        "info_false_gps": infoFalseGps,
        "is_wfh": isWfh,
        "status_tidak_masuk": statusTidakMasuk,
        "total_tanggungan": totalTanggungan,
        "is_saturday": isSaturday,
        "certificate": certificate,
        "certificate_url": certificateUrl,
        "penilaian": penilaian,
        "hybrid": hybrid,
        "wfh": wfh,
        "office_latitude": officeLatitude,
        "office_longitude": officeLongitude,
        "office_max_distance": officeMaxDistance,
      };
}
