// To parse this JSON data, do
//
//     final productDetail = productDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(Map<String, dynamic> str) =>
    ProductDetail.fromJson(str);

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
  ProductDetail({
    this.terjual = '',
    this.satuan = '',
    this.urlToko = '',
    this.toko = '',
    this.idToko = '',
    this.waCs = '',
    this.wa = '',
    this.stok = '',
    this.name = '',
    this.description = '',
    this.category = '',
    this.price = '',
    this.images = const [],
  });

  dynamic terjual;
  String satuan;
  String urlToko;
  String toko;
  String idToko;
  String waCs;
  String wa;
  String stok;
  String name;
  String description;
  String category;
  String price;
  List<Image> images;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        terjual: json["terjual"] ?? '0',
        satuan: json["satuan"] ?? '',
        urlToko: json["url_toko"] ?? '',
        toko: json["toko"] ?? '',
        idToko: json["id_toko"] ?? '',
        waCs: json["wa_cs"] ?? '-',
        wa: json["wa"] ?? '-',
        stok: json["stok"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '-',
        category: json["category"] ?? '',
        price: json["price"] ?? '',
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "terjual": terjual,
        "satuan": satuan,
        "url_toko": urlToko,
        "toko": toko,
        "id_toko": idToko,
        "wa_cs": waCs,
        "wa": wa,
        "stok": stok,
        "name": name,
        "description": description,
        "category": category,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.gambar,
  });

  String gambar;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        gambar: json["gambar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "gambar": gambar,
      };
}
