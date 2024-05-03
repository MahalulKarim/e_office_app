// To parse this JSON data, do
//
//     final agenSummaryResponse = agenSummaryResponseFromJson(jsonString);

import 'dart:convert';

AgenSummaryResponse agenSummaryResponseFromJson(String str) =>
    AgenSummaryResponse.fromJson(json.decode(str));

String agenSummaryResponseToJson(AgenSummaryResponse data) =>
    json.encode(data.toJson());

class AgenSummaryResponse {
  String status;
  AgenSummary data;
  String msg;

  AgenSummaryResponse({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory AgenSummaryResponse.fromJson(Map<String, dynamic> json) =>
      AgenSummaryResponse(
        status: json["status"],
        data: AgenSummary.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "msg": msg,
      };
}

class AgenSummary {
  int totalReff;
  int point;
  int dailyReport;

  AgenSummary({
    required this.totalReff,
    required this.point,
    required this.dailyReport,
  });

  factory AgenSummary.fromJson(Map<String, dynamic> json) => AgenSummary(
        totalReff: int.parse(json["total_reff"]),
        point: int.parse(json["point"]),
        dailyReport: int.parse(json["daily_report"]),
      );

  Map<String, dynamic> toJson() => {
        "total_reff": totalReff,
        "point": point,
        "daily_report": dailyReport,
      };
}
