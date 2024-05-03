import 'dart:convert';

RoAddressResponse roAddressResponseFromJson(String str) =>
    RoAddressResponse.fromJson(json.decode(str));

String roAddressResponseToJson(RoAddressResponse data) =>
    json.encode(data.toJson());

class RoAddressResponse {
  String status;
  List<RoAddress> data;
  String msg;

  RoAddressResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory RoAddressResponse.fromJson(Map<String, dynamic> json) =>
      RoAddressResponse(
        status: json["status"],
        data: List<RoAddress>.from(
            json["data"].map((x) => RoAddress.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class RoAddress {
  String provinceId;
  String cityId;
  String subdistrictId;
  String subdistrictName;
  String cityName;
  String provinceName;
  String address;

  RoAddress({
    this.provinceId = '',
    this.cityId = '',
    this.subdistrictId = '',
    this.subdistrictName = '',
    this.cityName = '',
    this.provinceName = '',
    this.address = '',
  });

  factory RoAddress.fromJson(Map<String, dynamic> json) => RoAddress(
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        subdistrictName: json["subdistrict_name"],
        cityName: json["city_name"],
        provinceName: json["province_name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "subdistrict_name": subdistrictName,
        "city_name": cityName,
        "province_name": provinceName,
        "address": address,
      };
}
