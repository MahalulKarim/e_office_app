// To parse this JSON data, do
//
//     final preSignupResponse = preSignupResponseFromJson(jsonString);

import 'dart:convert';

PreSignupResponse preSignupResponseFromJson(String str) =>
    PreSignupResponse.fromJson(json.decode(str));

String preSignupResponseToJson(PreSignupResponse data) =>
    json.encode(data.toJson());

class PreSignupResponse {
  PreSignupResponse({
    this.status,
    this.data,
    this.msg,
  });

  String? status;
  PreSignup? data;
  String? msg;

  factory PreSignupResponse.fromJson(Map<String, dynamic> json) =>
      PreSignupResponse(
        status: json["status"] ?? "",
        data: PreSignup.fromJson(json["data"] ?? []),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "msg": msg,
      };
}

class PreSignup {
  PreSignup({
    this.dataProvinces,
    this.dataLevel,
    this.dataJabatan,
  });

  List<DataProvince>? dataProvinces;
  List<DataLevel>? dataLevel;
  List<DataJabatan>? dataJabatan;

  factory PreSignup.fromJson(Map<String, dynamic> json) => PreSignup(
        dataProvinces: List<DataProvince>.from((json["data_provinces"] ?? [])
            .map((x) => DataProvince.fromJson(x))),
        dataLevel: List<DataLevel>.from(
            (json["data_level"] ?? []).map((x) => DataLevel.fromJson(x))),
        dataJabatan: List<DataJabatan>.from(
            (json["data_jabatan"] ?? []).map((x) => DataJabatan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_provinces":
            List<dynamic>.from((dataProvinces ?? []).map((x) => x.toJson())),
        "data_level":
            List<dynamic>.from((dataLevel ?? []).map((x) => x.toJson())),
        "data_jabatan":
            List<dynamic>.from((dataJabatan ?? []).map((x) => x.toJson())),
      };
}

class DataProvince {
  DataProvince({
    this.provinceId,
    this.provinceName,
    this.createdDate,
    this.updatedDate,
    this.deleteDate,
  });

  String? provinceId;
  String? provinceName;
  String? createdDate;
  String? updatedDate;
  dynamic deleteDate;

  factory DataProvince.fromJson(Map<String, dynamic> json) => DataProvince(
        provinceId: json["province_id"] ?? "",
        provinceName: json["province_name"] ?? "",
        createdDate: json["created_date"] ?? "",
        updatedDate: json["updated_date"] ?? "",
        deleteDate: json["delete_date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "delete_date": deleteDate,
      };
}

class DataLevel {
  DataLevel({
    this.id,
    this.level,
  });

  String? id;
  String? level;

  factory DataLevel.fromJson(Map<String, dynamic> json) => DataLevel(
        id: json["id"] ?? "",
        level: json["level"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
      };
}

class DataJabatan {
  DataJabatan({
    this.id,
    this.jabatan,
  });

  String? id;
  String? jabatan;

  factory DataJabatan.fromJson(Map<String, dynamic> json) => DataJabatan(
        id: json["id"] ?? "",
        jabatan: json["jabatan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jabatan": jabatan,
      };
}
