// To parse this JSON data, do
//
//     final guideDetailsModel = guideDetailsModelFromJson(jsonString);

import 'dart:convert';

GuideDetailsModel guideDetailsModelFromJson(String str) => GuideDetailsModel.fromJson(json.decode(str));

String guideDetailsModelToJson(GuideDetailsModel data) => json.encode(data.toJson());

class GuideDetailsModel {
  List<Vod>? vod;
  String? error;
  String? message;

  GuideDetailsModel({
    this.vod,
    this.error,
    this.message,
  });

  factory GuideDetailsModel.fromJson(Map<String, dynamic> json) => GuideDetailsModel(
        vod: json["vod"] == null ? [] : List<Vod>.from(json["vod"]!.map((x) => Vod.fromJson(x))),
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "vod": vod == null ? [] : List<dynamic>.from(vod!.map((x) => x.toJson())),
      };
}

class Vod {
  int? id;
  String? titel;
  String? beschreibung;
  String? url;
  String? thumbnail;

  Vod({
    this.id,
    this.titel,
    this.beschreibung,
    this.url,
    this.thumbnail,
  });

  factory Vod.fromJson(Map<String, dynamic> json) => Vod(
        id: json["id"],
        titel: json["titel"],
        beschreibung: json["beschreibung"],
        url: json["url"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titel": titel,
        "beschreibung": beschreibung,
        "url": url,
        "thumbnail": thumbnail,
      };
}
