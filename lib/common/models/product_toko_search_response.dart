// To parse this JSON data, do
//
//     final productTokoSearch = productTokoSearchFromJson(jsonString);

import 'dart:convert';

ProductTokoSearch productTokoSearchFromJson(String str) =>
    ProductTokoSearch.fromJson(json.decode(str));

String productTokoSearchToJson(ProductTokoSearch data) =>
    json.encode(data.toJson());

class ProductTokoSearch {
  ProductTokoSearch({
    required this.meta,
    required this.items,
  });

  Meta meta;
  List<Item> items;

  factory ProductTokoSearch.fromJson(Map<String, dynamic> json) =>
      ProductTokoSearch(
        meta: Meta.fromJson(json["meta"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.id,
    this.nama,
    this.harga_1,
    this.harga_2,
    this.tipe,
    this.thumb,
    this.telp,
  });

  String id;
  String? nama;
  int? harga_1;
  int? harga_2;
  String? tipe;
  String? thumb;
  String? telp;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        nama: json["nama"],
        harga_1: int.parse(json["harga_1"]),
        harga_2: int.parse(json["harga_2"]),
        tipe: json["tipe"],
        thumb: json["thumb"],
        telp: json["telp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga_1": harga_1,
        "harga_2": harga_2,
        "tipe": tipe,
        "thumb": thumb,
        "telp": telp,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
  });

  int currentPage;
  int totalPages;
  int limit;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "limit": limit,
      };
}
