// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);


class ContentModel {
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
  int popularity;
  UserId? userId;
  double? duration;
  String? tiktok;
  String? instragram;
  int likes;
  double? ratings;

  String? thumbnail;
  String? thumbnailPath;
  bool? isCurrentVideo;
  bool? isLiked;

  ContentModel({
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
  required  this.popularity,
    this.userId,
    this.duration,
    this.tiktok,
    this.instragram,
   required this.likes,
    this.ratings,

    this.thumbnail,
    this.thumbnailPath,
    this.isCurrentVideo,
    this.isLiked,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
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
    popularity: json["popularity"]??0,
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    duration: json["duration"]?.toDouble(),
    tiktok: json["tiktok"],
    instragram: json["instragram"],
    likes: json["likes"]??0,
    ratings:  json["ratings"].runtimeType==int?json["ratings"].toDouble():json["ratings"],
    thumbnail: json["thumbnail"],
    thumbnailPath: json["thumbnailPath"],
    isCurrentVideo: json["isCurrentVideo"],
    isLiked: json["isLiked"],
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
