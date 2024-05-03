// To parse this JSON data, do
//
//     final carousel = carouselFromJson(jsonString);

import 'dart:convert';

List<Carousel> carouselFromJson(List<dynamic> data) =>
    List<Carousel>.from(data.map((x) => Carousel.fromJson(x)));

String carouselToJson(List<Carousel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carousel {
  Carousel({
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

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
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
