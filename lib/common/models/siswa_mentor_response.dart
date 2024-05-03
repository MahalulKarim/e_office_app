// To parse this JSON data, do
//
//     final siswaMentorResponse = siswaMentorResponseFromJson(jsonString);

import 'dart:convert';

SiswaMentorResponse siswaMentorResponseFromJson(String str) =>
    SiswaMentorResponse.fromJson(json.decode(str));

String siswaMentorResponseToJson(SiswaMentorResponse data) =>
    json.encode(data.toJson());

class SiswaMentorResponse {
  String status;
  List<SiswaMentor> data;
  String msg;

  SiswaMentorResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory SiswaMentorResponse.fromJson(Map<String, dynamic> json) =>
      SiswaMentorResponse(
        status: json["status"],
        data: List<SiswaMentor>.from(
            json["data"].map((x) => SiswaMentor.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class SiswaMentor {
  String value;
  String label;

  SiswaMentor({
    required this.value,
    required this.label,
  });

  factory SiswaMentor.fromJson(Map<String, dynamic> json) => SiswaMentor(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
