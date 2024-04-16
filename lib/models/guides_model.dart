// To parse this JSON data, do
//
//     final guidesModel = guidesModelFromJson(jsonString);

import 'dart:convert';

GuidesModel guidesModelFromJson(String str) => GuidesModel.fromJson(json.decode(str));

String guidesModelToJson(GuidesModel data) => json.encode(data.toJson());

class GuidesModel {
  List<Vodtopic>? vodtopics;
  String? error;

  GuidesModel({
    this.vodtopics,
    this.error,
  });

  factory GuidesModel.fromJson(Map<String, dynamic> json) => GuidesModel(
        vodtopics: json["vodtopics"] == null
            ? []
            : List<Vodtopic>.from(json["vodtopics"]!.map((x) => Vodtopic.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "vodtopics": vodtopics == null ? [] : List<dynamic>.from(vodtopics!.map((x) => x.toJson())),
        "error": error
      };
}

class Vodtopic {
  int? id;
  String? topic;
  String? title;
  int? duration;
  String? thumbnail;

  Vodtopic({
    this.id,
    this.topic,
    this.title,
    this.duration,
    this.thumbnail,
  });

  factory Vodtopic.fromJson(Map<String, dynamic> json) => Vodtopic(
        id: json["id"],
        topic: json["topic"],
        title: json["title"],
        duration: json["duration"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "title": title,
        "duration": duration,
        "thumbnail": thumbnail,
      };
}
