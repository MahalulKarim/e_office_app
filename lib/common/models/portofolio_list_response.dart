// To parse this JSON data, do
//
//     final portofolioListResponse = portofolioListResponseFromJson(jsonString);

import 'dart:convert';

PortofolioListResponse portofolioListResponseFromJson(String str) =>
    PortofolioListResponse.fromJson(json.decode(str));

String portofolioListResponseToJson(PortofolioListResponse data) =>
    json.encode(data.toJson());

List<PortofolioList> portofolioListFromJson(List<dynamic> data) =>
    List<PortofolioList>.from(data.map((x) => PortofolioList.fromJson(x)));

class PortofolioListResponse {
  String? status;
  Data? data;
  String? msg;

  PortofolioListResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory PortofolioListResponse.fromJson(Map<String, dynamic> json) =>
      PortofolioListResponse(
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
  List<PortofolioList>? items;

  Data({
    this.meta,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        items: json["items"] == null
            ? []
            : List<PortofolioList>.from(
                json["items"]!.map((x) => PortofolioList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class PortofolioList {
  String? namaPegawai;
  String? asal;
  String? kodeKelas;
  String? bulan;
  String? linkGdrive;
  DateTime? createdDate;

  PortofolioList({
    this.namaPegawai,
    this.asal,
    this.kodeKelas,
    this.bulan,
    this.linkGdrive,
    this.createdDate,
  });

  factory PortofolioList.fromJson(Map<String, dynamic> json) => PortofolioList(
        namaPegawai: json["nama_pegawai"],
        asal: json["asal"],
        kodeKelas: json["kode_kelas"],
        bulan: json["bulan"],
        linkGdrive: json["link_gdrive"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "nama_pegawai": namaPegawai,
        "asal": asal,
        "kode_kelas": kodeKelas,
        "bulan": bulan,
        "link_gdrive": linkGdrive,
        "created_date":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
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
