// To parse this JSON data, do
//
//     final riwayatPoinResponse = riwayatPoinResponseFromJson(jsonString);

import 'dart:convert';

RiwayatPoinResponse riwayatPoinResponseFromJson(String str) =>
    RiwayatPoinResponse.fromJson(json.decode(str));

String riwayatPoinResponseToJson(RiwayatPoinResponse data) =>
    json.encode(data.toJson());

class RiwayatPoinResponse {
  String status;
  RiwayatPoinData data;
  String msg;

  RiwayatPoinResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory RiwayatPoinResponse.fromJson(Map<String, dynamic> json) =>
      RiwayatPoinResponse(
        status: json["status"],
        data: RiwayatPoinData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class RiwayatPoinData {
  int totalPages;
  int perPage;
  int currentPage;
  List<RiwayatPoin> items;

  RiwayatPoinData({
    required this.totalPages,
    required this.perPage,
    required this.currentPage,
    required this.items,
  });

  factory RiwayatPoinData.fromJson(Map<String, dynamic> json) =>
      RiwayatPoinData(
        totalPages: json["total_pages"] ?? 0,
        perPage: json["per_page"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        items: List<RiwayatPoin>.from(
            json["items"].map((x) => RiwayatPoin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "per_page": perPage,
        "current_page": currentPage,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class RiwayatPoin {
  String id;
  String idUser;
  String poin;
  String tanggal;
  String deskripsi;

  RiwayatPoin({
    required this.id,
    required this.idUser,
    required this.poin,
    required this.tanggal,
    required this.deskripsi,
  });

  factory RiwayatPoin.fromJson(Map<String, dynamic> json) => RiwayatPoin(
        id: json["id"],
        idUser: json["id_user"],
        poin: json["poin"],
        tanggal: json["tanggal"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "poin": poin,
        "tanggal": tanggal,
        "deskripsi": deskripsi,
      };
}
