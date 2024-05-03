// To parse this JSON data, do
//
//     final materiResponse = materiResponseFromJson(jsonString);

import 'dart:convert';

MateriResponse materiResponseFromJson(String str) =>
    MateriResponse.fromJson(json.decode(str));

String materiResponseToJson(MateriResponse data) => json.encode(data.toJson());

class MateriResponse {
  String status;
  MateriData data;
  String msg;

  MateriResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory MateriResponse.fromJson(Map<String, dynamic> json) => MateriResponse(
        status: json["status"],
        data: MateriData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class MateriData {
  List<Materi> items;
  Meta meta;

  MateriData({
    required this.items,
    required this.meta,
  });

  factory MateriData.fromJson(Map<String, dynamic> json) => MateriData(
        items: List<Materi>.from(json["items"].map((x) => Materi.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Materi {
  String id;
  String tgl;
  String namaMateri;
  String isi;
  String lampiran;
  String jenisMateri;

  Materi({
    required this.id,
    required this.tgl,
    required this.namaMateri,
    required this.isi,
    required this.lampiran,
    required this.jenisMateri,
  });

  factory Materi.fromJson(Map<String, dynamic> json) => Materi(
        id: json["id"],
        tgl: json["tgl"],
        namaMateri: json["nama_materi"],
        isi: json["isi"],
        lampiran: json["lampiran"],
        jenisMateri: json["jenis_materi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tgl": tgl,
        "nama_materi": namaMateri,
        "isi": isi,
        "lampiran": lampiran,
        "jenis_materi": jenisMateri,
      };
}

class Meta {
  int currentPage;
  int limit;
  int totalPages;

  Meta({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: int.parse(json["current_page"].toString()),
        limit: json["limit"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "limit": limit,
        "total_pages": totalPages,
      };
}
