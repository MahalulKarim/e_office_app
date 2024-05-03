// To parse this JSON data, do
//
//     final jelajahResponse = jelajahResponseFromJson(jsonString);

import 'dart:convert';

JelajahResponse jelajahResponseFromJson(String str) =>
    JelajahResponse.fromJson(json.decode(str));

String jelajahResponseToJson(JelajahResponse data) =>
    json.encode(data.toJson());

class JelajahResponse {
  String? status;
  List<Jelajah>? data;
  String? msg;

  JelajahResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory JelajahResponse.fromJson(Map<String, dynamic> json) =>
      JelajahResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Jelajah>.from(json["data"]!.map((x) => Jelajah.fromJson(x))),
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

class Jelajah {
  String? namaTugas;
  String? id;
  String? tujuan;
  String? ket;
  String? lat;
  String? lang;
  String? foto;
  String? urutan;
  int? countCompleted;
  bool? isUserCompleted;

  Jelajah({
    this.namaTugas,
    this.id,
    this.tujuan,
    this.ket,
    this.lat,
    this.lang,
    this.foto,
    this.urutan,
    this.countCompleted,
    this.isUserCompleted,
  });

  factory Jelajah.fromJson(Map<String, dynamic> json) => Jelajah(
        namaTugas: json["nama_tugas"],
        id: json["id"],
        tujuan: json["tujuan"],
        ket: json["ket"],
        lat: json["lat"],
        lang: json["lang"],
        foto: json["foto"],
        urutan: json["urutan"],
        countCompleted: json["count_completed"],
        isUserCompleted: json["is_user_completed"],
      );

  Map<String, dynamic> toJson() => {
        "nama_tugas": namaTugas,
        "id": id,
        "tujuan": tujuan,
        "ket": ket,
        "lat": lat,
        "lang": lang,
        "foto": foto,
        "urutan": urutan,
        "count_completed": countCompleted,
        "is_user_completed": isUserCompleted,
      };
}
