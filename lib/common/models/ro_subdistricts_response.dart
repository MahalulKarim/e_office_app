// To parse this JSON data, do
//
//     final roSubdistrictsResponse = roSubdistrictsResponseFromJson(jsonString);

import 'dart:convert';

RoSubdistrictsResponse roSubdistrictsResponseFromJson(String str) =>
    RoSubdistrictsResponse.fromJson(json.decode(str));

String roSubdistrictsResponseToJson(RoSubdistrictsResponse data) =>
    json.encode(data.toJson());

class RoSubdistrictsResponse {
  String? status;
  List<Subdistrict>? data;
  String? msg;

  RoSubdistrictsResponse({
    this.status,
    this.data,
    this.msg,
  });

  factory RoSubdistrictsResponse.fromJson(Map<String, dynamic> json) =>
      RoSubdistrictsResponse(
        status: json["status"] ?? "",
        data: List<Subdistrict>.from(
            (json["data"] ?? []).map((x) => Subdistrict.fromJson(x))),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "msg": msg,
      };
}

class Subdistrict {
  String? subdistrictId;
  String? cityId;
  String? subdistrictName;
  String? createdDate;
  String? updatedDate;
  dynamic deleteDate;

  Subdistrict({
    this.subdistrictId,
    this.cityId,
    this.subdistrictName,
    this.createdDate,
    this.updatedDate,
    this.deleteDate,
  });

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
        subdistrictId: json["subdistrict_id"] ?? "",
        cityId: json["city_id"] ?? "",
        subdistrictName: json["subdistrict_name"] ?? "",
        createdDate: json["created_date"] ?? "",
        updatedDate: json["updated_date"] ?? "",
        deleteDate: json["delete_date"],
      );

  Map<String, dynamic> toJson() => {
        "subdistrict_id": subdistrictId,
        "city_id": cityId,
        "subdistrict_name": subdistrictName,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "delete_date": deleteDate,
      };
}
