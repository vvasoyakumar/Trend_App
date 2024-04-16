import 'package:flutter/cupertino.dart';

class DetailDataModel {
  int? number;
  String image;
  String name;
  DetailDataModel({required this.name, required this.image, this.number});
}

class BottomNavigationBarItemModel {
  String? image;
  IconData? icon;
  String name;
  BottomNavigationBarItemModel({this.image, required this.name, this.icon});
}

class FullScreenVideoArgModel {
  String url;
  String title;
  String videoId;
  FullScreenVideoArgModel({required this.url, required this.title, required this.videoId});
}

class VideoDetailsPageArgModel {
  String videoId;
  VideoDetailsPageArgModel({required this.videoId});
}
