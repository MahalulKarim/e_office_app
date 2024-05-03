// To parse this JSON data, do
//
//     final referralListResponse = referralListResponseFromJson(jsonString);

import 'dart:convert';

ReferralListResponse referralListResponseFromJson(String str) =>
    ReferralListResponse.fromJson(json.decode(str));

String referralListResponseToJson(ReferralListResponse data) =>
    json.encode(data.toJson());

class ReferralListResponse {
  String status;
  ReferralListResponseData data;
  String msg;

  ReferralListResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory ReferralListResponse.fromJson(Map<String, dynamic> json) =>
      ReferralListResponse(
        status: json["status"],
        data: ReferralListResponseData.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class ReferralListResponseData {
  List<ReferralUser> items;
  Meta meta;

  ReferralListResponseData({
    required this.items,
    required this.meta,
  });

  factory ReferralListResponseData.fromJson(Map<String, dynamic> json) =>
      ReferralListResponseData(
        items: List<ReferralUser>.from(
            json["items"].map((x) => ReferralUser.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class ReferralUser {
  String id;
  String username;
  String email;
  String firstName;
  dynamic lastName;
  String phone;
  String alamat;
  String createdOn;

  ReferralUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    this.lastName,
    required this.phone,
    required this.alamat,
    this.createdOn = "0",
  });

  factory ReferralUser.fromJson(Map<String, dynamic> json) => ReferralUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        alamat: json["alamat"],
        createdOn: json["created_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "alamat": alamat,
        "created_on": createdOn
      };
}

class Meta {
  int perpage;
  int currentPage;
  int totalPages;

  Meta({
    required this.perpage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        perpage: json["perpage"],
        currentPage: int.parse(json["current_page"] ?? '1'),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "perpage": perpage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
