
import 'package:runwey_trend/model/content_model.dart';

class WishListModel {
  String? id;
  ContentModel? videoId;

  WishListModel({
    this.id,
    this.videoId,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    id: json["wishlistId"],
    videoId: json["videoId"] == null ? null : ContentModel.fromJson(json["videoId"]),
  );


}

class UserId {
  String? id;
  String? fullName;
  Image? image;

  UserId({
    this.id,
    this.fullName,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );


}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );


}

class VideoId {
  String? id;
  String? title;
  String? contentType;
  String? size;
  String? countryName;
  String? fabric;
  String? material;
  String? care;
  String? occassionCategory;
  String? gender;
  String? description;
  String? video;
  String? videoPath;
  int? popularity;
  String? userId;
  double? duration;
  int? likes;
  double? ratings;
  String? thumbnail;
  String? thumbnailPath;


  VideoId({
    this.id,
    this.title,
    this.contentType,
    this.size,
    this.countryName,
    this.fabric,
    this.material,
    this.care,
    this.occassionCategory,
    this.gender,
    this.description,
    this.video,
    this.videoPath,
    this.popularity,
    this.userId,
    this.duration,
    this.likes,
    this.ratings,
    this.thumbnail,
    this.thumbnailPath,

  });

  factory VideoId.fromJson(Map<String, dynamic> json) => VideoId(
    id: json["_id"],
    title: json["title"],
    contentType: json["contentType"],
    size: json["size"],
    countryName: json["countryName"],
    fabric: json["fabric"],
    material: json["material"],
    care: json["care"],
    occassionCategory: json["occassionCategory"],
    gender: json["gender"],
    description: json["description"],
    video: json["video"],
    videoPath: json["videoPath"],
    popularity: json["popularity"],
    userId: json["userId"],
    duration: json["duration"]?.toDouble(),
    likes: json["likes"],
    ratings:  json["ratings"].runtimeType==int?json["ratings"].toDouble():json["ratings"],
    thumbnail: json["thumbnail"],
    thumbnailPath: json["thumbnailPath"],

  );


}
