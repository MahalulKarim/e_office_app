// To parse this JSON data, do
//
//     final ads = adsFromJson(jsonString);

import 'dart:convert';

List<Ads> adsFromJson(List<dynamic> data) =>
    List<Ads>.from(data.map((x) => Ads.fromJson(x)));

String adsToJson(List<Ads> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
  Ads({
    required this.idIklan,
    required this.iklan,
    required this.judul,
    required this.deskripsi,
    this.status,
  });

  String idIklan;
  String iklan;
  String judul;
  String deskripsi;
  dynamic status;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        idIklan: json["id_iklan"],
        iklan: json["iklan"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_iklan": idIklan,
        "iklan": iklan,
        "judul": judul,
        "deskripsi": deskripsi,
        "status": status,
      };
}
