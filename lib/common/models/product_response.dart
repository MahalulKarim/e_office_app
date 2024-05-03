// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(List<dynamic> data) =>
    List<Product>.from(data.map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.idProduk,
    this.urlToko,
    this.namaProduk,
    this.url,
    this.harga1,
    this.urlProduk,
    this.idKategori,
    this.satuan,
    this.berat,
    this.satuanBerat,
    this.namaGambar,
    this.idToko,
    this.namaToko,
    this.thumb,
    this.harga,
  });

  String idProduk;
  String? urlToko;
  String? namaProduk;
  String? url;
  String? harga1;
  String? urlProduk;
  String? idKategori;
  String? satuan;
  String? berat;
  String? satuanBerat;
  String? namaGambar;
  String? idToko;
  String? namaToko;
  String? thumb;
  String? harga;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idProduk: json["id_produk"],
        urlToko: json["url_toko"] ?? "",
        namaProduk: json["nama_produk"] ?? "",
        url: json["url"] ?? "",
        harga1: json["harga_1"] ?? "",
        urlProduk: json["url_produk"] ?? "",
        idKategori: json["id_kategori"] ?? "",
        satuan: json["satuan"] ?? "",
        berat: json["berat"] ?? "",
        satuanBerat: json["satuan_berat"] ?? "",
        namaGambar: json["nama_gambar"] ?? "",
        idToko: json["id_toko"] ?? "",
        namaToko: json["nama_toko"] ?? "",
        thumb: json["thumb"] ?? "",
        harga: json["harga"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id_produk": idProduk,
        "url_toko": urlToko,
        "nama_produk": namaProduk,
        "url": url,
        "harga_1": harga1,
        "url_produk": urlProduk,
        "id_kategori": idKategori,
        "satuan": satuan,
        "berat": berat,
        "satuan_berat": satuanBerat,
        "nama_gambar": namaGambar,
        "id_toko": idToko,
        "nama_toko": namaToko,
        "thumb": thumb,
        "harga": harga,
      };
}
