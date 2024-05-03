// To parse this JSON data, do
//
//     final roCitiesResponse = roCitiesResponseFromJson(jsonString);

import 'dart:convert';

RoCitiesResponse roCitiesResponseFromJson(String str) =>
    RoCitiesResponse.fromJson(json.decode(str));

String roCitiesResponseToJson(RoCitiesResponse data) =>
    json.encode(data.toJson());

class RoCitiesResponse {
  String? status;
  List<City>? data;
  String? msg;

  RoCitiesResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory RoCitiesResponse.fromJson(Map<String, dynamic> json) =>
      RoCitiesResponse(
        status: json["status"] ?? "",
        data:
            List<City>.from((json["data"] ?? []).map((x) => City.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "msg": msg,
      };
}

class City {
  String? cityId;
  String? provinceId;
  String? cityName;
  String? postalCode;
  String? createdDate;
  String? updatedDate;
  dynamic deleteDate;

  City({
    this.cityId,
    this.provinceId,
    this.cityName,
    this.postalCode,
    this.createdDate,
    this.updatedDate,
    this.deleteDate,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json["city_id"] ?? "",
        provinceId: json["province_id"] ?? "",
        cityName: json["city_name"] ?? "",
        postalCode: json["postal_code"] ?? "",
        createdDate: json["created_date"] ?? "",
        updatedDate: json["updated_date"] ?? "",
        deleteDate: json["delete_date"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "city_name": cityName,
        "postal_code": postalCode,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "delete_date": deleteDate,
      };
}
