// To parse this JSON data, do
//
//     final tvLiveResponse = tvLiveResponseFromJson(jsonString);

import 'dart:convert';

List<TvLiveResponse> tvLiveResponseFromJson(String str) =>
    List<TvLiveResponse>.from(
        json.decode(str).map((x) => TvLiveResponse.fromJson(x)));

String tvLiveResponseToJson(List<TvLiveResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TvLiveResponse {
  TvLiveResponse({
    required this.id,
    required this.nama,
    required this.url,
  });

  String id;
  String nama;
  String url;

  factory TvLiveResponse.fromJson(Map<String, dynamic> json) => TvLiveResponse(
        id: json["id"],
        nama: json["nama"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "url": url,
      };
}
