// To parse this JSON data, do
//
//     final categoryDetailsModel = categoryDetailsModelFromJson(jsonString);

import 'dart:convert';

List<CategoryDetailsModel> categoryDetailsModelFromJson(String str) =>
    List<CategoryDetailsModel>.from(json.decode(str).map((x) => CategoryDetailsModel.fromJson(x)));

String categoryDetailsModelToJson(List<CategoryDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryDetailsModel {
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
  String? sourceVideoUrl;
  String? publicVideoUrl;
  String? songTitle;
  String? songUrl;
  String? description;
  List<String>? hashtags;

  CategoryDetailsModel({
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
    this.sourceVideoUrl,
    this.publicVideoUrl,
    this.songTitle,
    this.songUrl,
    this.description,
    this.hashtags,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => CategoryDetailsModel(
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
        sourceVideoUrl: json["SourceVideoURL"],
        publicVideoUrl: json["PublicVideoURL"],
        songTitle: json["SongTitle"],
        songUrl: json["SongUrl"],
        description: json["Description"],
        hashtags: json["Hashtags"] == null ? [] : List<String>.from(json["Hashtags"]!.map((x) => x)),
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
        "SourceVideoURL": sourceVideoUrl,
        "PublicVideoURL": publicVideoUrl,
        "SongTitle": songTitle,
        "SongUrl": songUrl,
        "Description": description,
        "Hashtags": hashtags == null ? [] : List<dynamic>.from(hashtags!.map((x) => x)),
      };
}
