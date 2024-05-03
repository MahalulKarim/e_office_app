// To parse this JSON data, do
//
//     final sponsor = sponsorFromJson(jsonString);

import 'dart:convert';

List<Sponsor> sponsorFromJson(List<dynamic> data) =>
    List<Sponsor>.from(data.map((x) => Sponsor.fromJson(x)));

String sponsorToJson(List<Sponsor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sponsor {
  Sponsor({
    required this.idSlider,
    required this.gambar,
    this.judul,
    this.deskripsi,
    this.status,
  });

  String idSlider;
  String gambar;
  dynamic judul;
  dynamic deskripsi;
  dynamic status;

  factory Sponsor.fromJson(Map<String, dynamic> json) => Sponsor(
        idSlider: json["id_slider"],
        gambar: json["gambar"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_slider": idSlider,
        "gambar": gambar,
        "judul": judul,
        "deskripsi": deskripsi,
        "status": status,
      };
}
