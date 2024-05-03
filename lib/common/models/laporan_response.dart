// To parse this JSON data, do
//
//     final laporanResponse = laporanResponseFromJson(jsonString);

import 'dart:convert';

LaporanResponse laporanResponseFromJson(String str) =>
    LaporanResponse.fromJson(json.decode(str));

String laporanResponseToJson(LaporanResponse data) =>
    json.encode(data.toJson());

class LaporanResponse {
  LaporanResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  Data? data;
  String? msg;

  factory LaporanResponse.fromJson(Map<String, dynamic> json) =>
      LaporanResponse(
        status: json["status"] ?? "",
        data: Data.fromJson(json["data"] ?? []),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : data!.toJson(),
        "msg": msg,
      };
}

class Data {
  Data({
    this.page,
    this.limit,
    this.periodStart,
    this.periodEnd,
    this.totalPage,
    this.offset,
    this.now,
    this.data,
    this.isLast,
  });

  int? page;
  int? limit;
  String? periodStart;
  String? periodEnd;
  int? totalPage;
  int? offset;
  String? now;
  List<TugasSimple>? data;
  int? isLast;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        page: json["page"] ?? 0,
        limit: json["limit"] ?? 0,
        periodStart: json["period_start"] ?? "",
        periodEnd: json["period_end"] ?? "",
        totalPage: json["total_page"] ?? 0,
        offset: json["offset"] ?? 0,
        now: json["now"] ?? "",
        data: List<TugasSimple>.from(
            (json["data"] ?? []).map((x) => TugasSimple.fromJson(x))),
        isLast: json["isLast"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "period_start": periodStart,
        "period_end": periodEnd,
        "total_page": totalPage,
        "offset": offset,
        "now": now,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "isLast": isLast,
      };
}

class TugasSimple {
  TugasSimple({
    this.tgl,
    this.day,
    this.month,
    this.year,
    this.textDay,
    this.textMonth,
    this.isDividerFirstMonth,
    this.isDividerLastMonth,
    this.dateIsMore,
    this.dateIsNow,
    this.dateIsLess,
    this.isHoliday,
    this.holidayDescription,
    this.status,
    this.jamMasuk,
    this.jamPulang,
    this.statusTidakMasuk,
    this.isWfh,
    this.listUploadPagi,
    this.listUploadSiang,
    this.listUploadTanggungan,
  });

  String? tgl;
  String? day;
  String? month;
  String? year;
  String? textDay;
  String? textMonth;
  int? isDividerFirstMonth;
  int? isDividerLastMonth;
  int? dateIsMore;
  int? dateIsNow;
  int? dateIsLess;
  int? isHoliday;
  String? holidayDescription;
  int? status;
  String? jamMasuk;
  String? jamPulang;
  int? statusTidakMasuk;
  int? isWfh;
  List<ListUpload>? listUploadPagi;
  List<ListUpload>? listUploadSiang;
  List<ListUpload>? listUploadTanggungan;

  factory TugasSimple.fromJson(Map<String, dynamic> json) => TugasSimple(
        tgl: json["tgl"] ?? "",
        day: json["day"] ?? "",
        month: json["month"] ?? "",
        year: json["year"] ?? "",
        textDay: json["text_day"] ?? "",
        textMonth: json["text_month"] ?? "",
        isDividerFirstMonth: json["is_divider_first_month"] ?? "",
        isDividerLastMonth: json["is_divider_last_month"] ?? "",
        dateIsMore: json["date_is_more"] ?? 0,
        dateIsNow: json["date_is_now"] ?? 0,
        dateIsLess: json["date_is_less"] ?? 0,
        isHoliday: json["is_holiday"] ?? 0,
        holidayDescription: json["holiday_description"] ?? "",
        status: json["status"] ?? 0,
        jamMasuk: json["jam_masuk"] ?? "",
        jamPulang: json["jam_pulang"] ?? "",
        statusTidakMasuk: json["status_tidak_masuk"] ?? 0,
        isWfh: json["is_wfh"] ?? 0,
        listUploadPagi: List<ListUpload>.from((json["list_upload_pagi"] ?? [])
            .map((x) => ListUpload.fromJson(x))),
        listUploadSiang: List<ListUpload>.from((json["list_upload_siang"] ?? [])
            .map((x) => ListUpload.fromJson(x))),
        listUploadTanggungan: List<ListUpload>.from(
            (json["list_upload_tanggungan"] ?? [])
                .map((x) => ListUpload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tgl": tgl,
        "day": day,
        "month": month,
        "year": year,
        "text_day": textDay,
        "text_month": textMonth,
        "is_divider_first_month": isDividerFirstMonth,
        "is_divider_last_month": isDividerLastMonth,
        "date_is_more": dateIsMore,
        "date_is_now": dateIsNow,
        "date_is_less": dateIsLess,
        "is_holiday": isHoliday,
        "holiday_description": holidayDescription,
        "status": status,
        "jam_masuk": jamMasuk,
        "jam_pulang": jamPulang,
        "status_tidak_masuk": statusTidakMasuk,
        "is_wfh": isWfh,
        "list_upload_pagi":
            List<dynamic>.from((listUploadPagi ?? []).map((x) => x.toJson())),
        "list_upload_siang":
            List<dynamic>.from((listUploadSiang ?? []).map((x) => x.toJson())),
        "list_upload_tanggungan": List<dynamic>.from(
            (listUploadTanggungan ?? []).map((x) => x.toJson())),
      };
}

class ListUpload {
  ListUpload({
    this.id,
    this.tgl,
    this.judul,
    this.tugas,
    this.ket,
    this.file,
    this.progress,
    this.selesai,
    this.urlFile,
  });

  String? id;
  String? tgl;
  String? judul;
  String? tugas;
  String? ket;
  String? file;
  String? progress;
  String? selesai;
  String? urlFile;

  factory ListUpload.fromJson(Map<String, dynamic> json) => ListUpload(
        id: json["id"] ?? "",
        tgl: json["tgl"] ?? "",
        judul: json["judul"] ?? "",
        tugas: json["tugas"] ?? "",
        ket: json["ket"] ?? "",
        file: json["file"] ?? "",
        progress: json["progress"] ?? "",
        selesai: json["selesai"] ?? "",
        urlFile: json["url_file"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tgl": tgl,
        "judul": judul,
        "tugas": tugas,
        "ket": ket,
        "file": file,
        "progress": progress,
        "selesai": selesai,
        "url_file": urlFile,
      };
}
