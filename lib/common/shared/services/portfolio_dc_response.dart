// To parse this JSON data, do
//
//     final portfolioDcResponse = portfolioDcResponseFromJson(jsonString);

import 'dart:convert';

PortfolioDcResponse portfolioDcResponseFromJson(String str) =>
    PortfolioDcResponse.fromJson(json.decode(str));

String portfolioDcResponseToJson(PortfolioDcResponse data) =>
    json.encode(data.toJson());

class PortfolioDcResponse {
  String status;
  Data data;
  String msg;

  PortfolioDcResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory PortfolioDcResponse.fromJson(Map<String, dynamic> json) =>
      PortfolioDcResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class Data {
  Meta meta;
  List<PortfolioDC> items;

  Data({
    required this.meta,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meta: Meta.fromJson(json["meta"]),
        items: List<PortfolioDC>.from(
            json["items"].map((x) => PortfolioDC.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class PortfolioDC {
  String id;
  String idUsers;
  String bulan;
  String linkGdrive;
  String createdDate;
  String namaPegawai;
  String asal;

  PortfolioDC({
    required this.id,
    required this.idUsers,
    required this.bulan,
    required this.linkGdrive,
    required this.createdDate,
    required this.namaPegawai,
    required this.asal,
  });

  factory PortfolioDC.fromJson(Map<String, dynamic> json) => PortfolioDC(
      id: json["id"],
      idUsers: json["id_users"],
      bulan: json["bulan"],
      linkGdrive: json["link_gdrive"],
      createdDate: json["created_date"],
      asal: json['asal'],
      namaPegawai: json['nama_pegawai']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_users": idUsers,
        "bulan": bulan,
        "link_gdrive": linkGdrive,
        "created_date": createdDate,
      };
}

class Meta {
  int page;
  int limit;

  Meta({
    required this.page,
    required this.limit,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: int.parse(json["page"].toString()),
        limit: int.parse(json["limit"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
      };
}
