// To parse this JSON data, do
//
//     final logo = logoFromJson(jsonString);

import 'dart:convert';

List<Logo> logoFromJson(List<dynamic> data) =>
    List<Logo>.from(data.map((x) => Logo.fromJson(x)));

String logoToJson(List<Logo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Logo {
  Logo({
    required this.idLogo,
    required this.logo,
    this.judul,
    this.deskripsi,
    this.status,
  });

  String idLogo;
  String logo;
  dynamic judul;
  dynamic deskripsi;
  dynamic status;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        idLogo: json["id_logo"],
        logo: json["logo"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_logo": idLogo,
        "logo": logo,
        "judul": judul,
        "deskripsi": deskripsi,
        "status": status,
      };
}
