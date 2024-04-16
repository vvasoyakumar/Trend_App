// To parse this JSON data, do
//
//     final videoDetailsModel = videoDetailsModelFromJson(jsonString);

import 'dart:convert';

VideoDetailsModel videoDetailsModelFromJson(String str) => VideoDetailsModel.fromJson(json.decode(str));

String videoDetailsModelToJson(VideoDetailsModel data) => json.encode(data.toJson());

class VideoDetailsModel {
  Video? video;
  List<Stat>? stats;
  String? error;

  VideoDetailsModel({
    this.video,
    this.stats,
    this.error,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        stats: json["stats"] == null ? [] : List<Stat>.from(json["stats"]!.map((x) => Stat.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "video": video?.toJson(),
        "stats": stats == null ? [] : List<dynamic>.from(stats!.map((x) => x.toJson())),
        "error": error
      };
}

class Stat {
  DateTime? timestamp;
  int? viewCount;

  Stat({
    this.timestamp,
    this.viewCount,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
        viewCount: json["viewCount"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp?.toIso8601String(),
        "viewCount": viewCount,
      };
}

class Video {
  String? videoId;
  String? username;
  String? avatarImage;
  int? follower;
  int? likes;
  List<int>? category;
  DateTime? datePosted;
  int? hotness;
  int? views;
  int? favorites;
  String? publicVideoUrl;
  String? sourceVideoUrl;
  String? songTitle;
  String? songUrl;
  List<String>? hashtags;
  String? description;

  Video({
    this.videoId,
    this.username,
    this.avatarImage,
    this.follower,
    this.likes,
    this.category,
    this.datePosted,
    this.hotness,
    this.views,
    this.favorites,
    this.publicVideoUrl,
    this.sourceVideoUrl,
    this.songTitle,
    this.songUrl,
    this.hashtags,
    this.description,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        videoId: json["videoId"],
        username: json["Username"],
        avatarImage: json["AvatarImage"],
        follower: json["Follower"],
        likes: json["Likes"],
        category: json["Category"] == null ? [] : List<int>.from(json["Category"]!.map((x) => x)),
        datePosted: json["Date-posted"] == null ? null : DateTime.parse(json["Date-posted"]),
        hotness: json["Hotness"],
        views: json["Views"],
        favorites: json["Favorites"],
        publicVideoUrl: json["PublicVideoURL"],
        sourceVideoUrl: json["SourceVideoURL"],
        songTitle: json["SongTitle"],
        songUrl: json["SongUrl"],
        hashtags: json["Hashtags"] == null ? [] : List<String>.from(json["Hashtags"]!.map((x) => x)),
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "Username": username,
        "AvatarImage": avatarImage,
        "Follower": follower,
        "Likes": likes,
        "Category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
        "Date-posted": datePosted?.toIso8601String(),
        "Hotness": hotness,
        "Views": views,
        "Favorites": favorites,
        "PublicVideoURL": publicVideoUrl,
        "SourceVideoURL": sourceVideoUrl,
        "SongTitle": songTitle,
        "SongUrl": songUrl,
        "Hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
        "Description": description,
      };
}
