// To parse this JSON data, do
//
//     final tingkatResponse = tingkatResponseFromJson(jsonString);

import 'dart:convert';

TingkatResponse tingkatResponseFromJson(String str) =>
    TingkatResponse.fromJson(json.decode(str));

String tingkatResponseToJson(TingkatResponse data) =>
    json.encode(data.toJson());

class TingkatResponse {
  TingkatResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  List<Tingkat>? data;
  String? msg;

  factory TingkatResponse.fromJson(Map<String, dynamic> json) =>
      TingkatResponse(
        status: json["status"],
        data: List<Tingkat>.from(json["data"].map((x) => Tingkat.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Tingkat {
  Tingkat({
    this.id,
    this.idJabatan,
    this.tingkat,
    this.ket,
    this.orders,
  });

  String? id;
  String? idJabatan;
  String? tingkat;
  String? ket;
  String? orders;

  factory Tingkat.fromJson(Map<String, dynamic> json) => Tingkat(
        id: json["id"] ?? "",
        idJabatan: json["id_jabatan"] ?? "",
        tingkat: json["tingkat"] ?? "",
        ket: json["ket"] ?? "",
        orders: json["orders"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_jabatan": idJabatan,
        "tingkat": tingkat,
        "ket": ket,
        "orders": orders,
      };
}
