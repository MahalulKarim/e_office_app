// To parse this JSON data, do
//
//     final roProvincesResponse = roProvincesResponseFromJson(jsonString);

import 'dart:convert';

RoProvincesResponse roProvincesResponseFromJson(String str) =>
    RoProvincesResponse.fromJson(json.decode(str));

String roProvincesResponseToJson(RoProvincesResponse data) =>
    json.encode(data.toJson());

class RoProvincesResponse {
  String? status;
  List<Province>? data;
  String? msg;

  RoProvincesResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory RoProvincesResponse.fromJson(Map<String, dynamic> json) =>
      RoProvincesResponse(
        status: json["status"] ?? "",
        data: List<Province>.from(
            (json["data"] ?? []).map((x) => Province.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "msg": msg,
      };
}

class Province {
  String? provinceId;
  String? provinceName;
  String? createdDate;
  String? updatedDate;
  dynamic deleteDate;

  Province({
    this.provinceId,
    this.provinceName,
    this.createdDate,
    this.updatedDate,
    this.deleteDate,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"] ?? "",
        provinceName: json["province_name"] ?? "",
        createdDate: json["created_date"] ?? "",
        updatedDate: json["updated_date"] ?? "",
        deleteDate: json["delete_date"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "delete_date": deleteDate,
      };
}
