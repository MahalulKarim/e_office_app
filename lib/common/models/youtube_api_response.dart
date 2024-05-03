// To parse this JSON data, do
//
//     final youtubeApiResponse = youtubeApiResponseFromJson(jsonString);

import 'dart:convert';

YoutubeApiResponse youtubeApiResponseFromJson(String str) =>
    YoutubeApiResponse.fromJson(json.decode(str));

String youtubeApiResponseToJson(YoutubeApiResponse data) =>
    json.encode(data.toJson());

class YoutubeApiResponse {
  List<YoutubeVideo> items;
  Meta meta;

  YoutubeApiResponse({
    required this.items,
    required this.meta,
  });

  factory YoutubeApiResponse.fromJson(Map<String, dynamic> json) =>
      YoutubeApiResponse(
        items: List<YoutubeVideo>.from(
            json["items"].map((x) => YoutubeVideo.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class YoutubeVideo {
  int id;
  String title;
  String thumbnail;
  String videoId;
  String description;
  String publishedTime;
  String channelName;
  String type;
  String createdDate;
  String updatedDate;
  dynamic deletedDate;

  YoutubeVideo({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.videoId,
    required this.description,
    required this.publishedTime,
    required this.channelName,
    required this.type,
    required this.createdDate,
    required this.updatedDate,
    this.deletedDate,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) => YoutubeVideo(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        videoId: json["videoId"],
        description: json["description"],
        publishedTime: json["publishedTime"],
        channelName: json["channelName"],
        type: json["type"],
        createdDate: json["created_date"],
        updatedDate: json["updated_date"],
        deletedDate: json["deleted_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "videoId": videoId,
        "description": description,
        "publishedTime": publishedTime,
        "channelName": channelName,
        "type": type,
        "created_date": createdDate,
        "updated_date": updatedDate,
        "deleted_date": deletedDate,
      };
}

class Meta {
  int totalItems;
  int itemCount;
  int itemsPerPage;
  int totalPages;
  int currentPage;

  Meta({
    required this.totalItems,
    required this.itemCount,
    required this.itemsPerPage,
    required this.totalPages,
    required this.currentPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalItems: json["totalItems"],
        itemCount: json["itemCount"],
        itemsPerPage: json["itemsPerPage"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "itemCount": itemCount,
        "itemsPerPage": itemsPerPage,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}
