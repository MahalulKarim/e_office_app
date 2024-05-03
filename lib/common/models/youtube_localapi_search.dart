// To parse this JSON data, do
//
//     final youtubeLocalApiSearch = youtubeLocalApiSearchFromJson(jsonString);

import 'dart:convert';

YoutubeLocalApiSearch youtubeLocalApiSearchFromJson(String str) =>
    YoutubeLocalApiSearch.fromJson(json.decode(str));

String youtubeLocalApiSearchToJson(YoutubeLocalApiSearch data) =>
    json.encode(data.toJson());

class YoutubeLocalApiSearch {
  YoutubeLocalApiSearch({
    required this.items,
    this.nextPageToken,
  });

  List<Item> items;
  String? nextPageToken;

  factory YoutubeLocalApiSearch.fromJson(Map<String, dynamic> json) =>
      YoutubeLocalApiSearch(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        nextPageToken: json["nextPageToken"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
      };
}

class Item {
  Item({
    required this.videoId,
    required this.thumbnails,
    required this.title,
    required this.description,
    required this.publishedTimeText,
    required this.viewCountText,
    required this.ownerText,
  });

  String videoId;
  List<Thumbnail> thumbnails;
  String title;
  String description;
  String publishedTimeText;
  String viewCountText;
  String ownerText;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        videoId: json["videoId"],
        thumbnails: List<Thumbnail>.from(
            json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
        description: json["description"],
        publishedTimeText: json["publishedTimeText"],
        viewCountText: json["viewCountText"],
        ownerText: json["ownerText"],
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title,
        "description": description,
        "publishedTimeText": publishedTimeText,
        "viewCountText": viewCountText,
        "ownerText": ownerText,
      };
}

class Thumbnail {
  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
