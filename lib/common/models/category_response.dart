import 'dart:convert';

List<Category> categoryFromJson(List<dynamic> data) =>
    List<Category>.from(data.map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.idKategori,
    required this.namaKategori,
    required this.url,
    required this.icon,
  });

  String idKategori;
  String namaKategori;
  String url;
  String icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idKategori: json["id_kategori"],
        namaKategori: json["nama_kategori"],
        url: json["url"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": idKategori,
        "nama_kategori": namaKategori,
        "url": url,
        "icon": icon,
      };
}
