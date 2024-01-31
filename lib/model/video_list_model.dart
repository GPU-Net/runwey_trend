// // To parse this JSON data, do
// //
// //     final videoListModel = videoListModelFromJson(jsonString);
//
// import 'dart:convert';
//
//
//
// class VideoListModel {
//   String? id;
//   String? title;
//   String? size;
//   String? countryName;
//   String? fabric;
//   String? material;
//   String? care;
//   String? occassionCategory;
//   String? gender;
//   String? description;
//   String? videoPath;
//   int? popularity;
//   UserId? userId;
//   double? duration;
//   String? thumbnail;
//   String? thumbnailPath;
//   String? tiktok;
//   String? instragram;
//
//   VideoListModel({
//     this.id,
//     this.title,
//     this.size,
//     this.countryName,
//     this.fabric,
//     this.material,
//     this.care,
//     this.occassionCategory,
//     this.gender,
//     this.description,
//     this.videoPath,
//     this.popularity,
//     this.userId,
//     this.duration,
//     this.thumbnail,
//     this.thumbnailPath,
//     this.tiktok,
//     this.instragram,
//   });
//
//   factory VideoListModel.fromJson(Map<String, dynamic> json) => VideoListModel(
//     id: json["_id"],
//     title: json["title"],
//     size: json["size"],
//     countryName: json["countryName"],
//     fabric: json["fabric"],
//     material: json["material"],
//     care: json["care"],
//     occassionCategory: json["occassionCategory"]!,
//     gender: json["gender"]!,
//     description: json["description"],
//     videoPath: json["videoPath"],
//     popularity: json["popularity"],
//     userId: json["userId"]!,
//     duration: json["duration"]?.toDouble(),
//     thumbnail: json["thumbnail"],
//     thumbnailPath: json["thumbnailPath"],
//     tiktok: json["tiktok"],
//     instragram: json["instragram"],
//   );
//
// }
//
// // To parse this JSON data, do
// //
// //     final userId = userIdFromJson(jsonString);
//
// class UserId {
//   String? id;
//   String? fullName;
//   Image? image;
//
//   UserId({
//     this.id,
//     this.fullName,
//     this.image,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     id: json["_id"],
//     fullName: json["fullName"],
//     image: json["image"] == null ? null : Image.fromJson(json["image"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "fullName": fullName,
//     "image": image?.toJson(),
//   };
// }
//
// class Image {
//   String? publicFileUrl;
//   String? path;
//
//   Image({
//     this.publicFileUrl,
//     this.path,
//   });
//
//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//     publicFileUrl: json["publicFileUrl"],
//     path: json["path"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "publicFileUrl": publicFileUrl,
//     "path": path,
//   };
// }
//
