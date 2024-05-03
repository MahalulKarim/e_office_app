// To parse this JSON data, do
//
//     final storeDetail = storeDetailFromJson(jsonString);

import 'dart:convert';

List<StoreDetail> storeListFromJson(List<dynamic> data) =>
    List<StoreDetail>.from(data.map((x) => StoreDetail.fromJson(x)));

StoreDetail storeDetailFromJson(Map<String, dynamic> str) =>
    StoreDetail.fromJson(str);

String storeDetailToJson(StoreDetail data) => json.encode(data.toJson());

class StoreDetail {
  StoreDetail({
    this.url = '',
    this.id = '',
    this.namaToko = '',
    this.slug = '',
    this.provinceId = '',
    this.cityId = '',
    this.subdistrictId = '',
    this.city = '',
    this.alamat = '',
    this.telp = '',
    this.cc = '',
    this.wa = '',
    this.waCs = '',
    this.email = '',
    this.logo = '',
    this.deskripsi = '',
    this.cover = '',
    this.bagiHasil = '',
    this.saldo = '',
  });

  String url;
  String id;
  String namaToko;
  String slug;
  String provinceId;
  String cityId;
  String subdistrictId;
  String city;
  String alamat;
  String telp;
  String cc;
  String wa;
  String waCs;
  String email;
  String logo;
  dynamic deskripsi;
  dynamic cover;
  String bagiHasil;
  dynamic saldo;

  factory StoreDetail.fromJson(Map<String, dynamic> json) => StoreDetail(
        url: json["url"] ?? "",
        id: json["id"] ?? "",
        namaToko: json["nama_toko"] ?? "",
        slug: json["slug"] ?? "",
        provinceId: json["province_id"] ?? "",
        cityId: json["city_id"] ?? "",
        subdistrictId: json["subdistrict_id"] ?? "",
        city: json["city"] ?? "",
        alamat: json["alamat"] ?? "",
        telp: json["telp"] ?? "",
        cc: json["cc"] ?? "",
        wa: json["wa"] ?? "",
        waCs: json["wa_cs"] ?? "" ?? '-',
        email: json["email"] ?? "",
        logo: json["logo"] ?? "",
        deskripsi: json["deskripsi"] ?? "",
        cover: json["cover"] ?? "",
        bagiHasil: json["bagi_hasil"] ?? "",
        saldo: json["saldo"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "nama_toko": namaToko,
        "slug": slug,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "city": city,
        "alamat": alamat,
        "telp": telp,
        "cc": cc,
        "wa": wa,
        "wa_cs": waCs,
        "email": email,
        "logo": logo,
        "deskripsi": deskripsi,
        "cover": cover,
        "bagi_hasil": bagiHasil,
        "saldo": saldo,
      };
}
