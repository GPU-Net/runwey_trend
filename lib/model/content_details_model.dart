
class ContentDetailsModel {
  final Attributes? attributes;

  ContentDetailsModel({
    this.attributes,
  });

  factory ContentDetailsModel.fromJson(Map<String, dynamic> json) => ContentDetailsModel(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );


}

class Attributes {
  final Video? video;
  final List<Reviews>? reviews;
  final List<SimilarVideo>? similarVideos;
  final Pagination? pagination;

  Attributes({
    this.video,
    this.reviews,
    this.similarVideos,
    this.pagination,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
    reviews: json["reviews"] == null ? [] : List<Reviews>.from(json["reviews"]!.map((x) => Reviews.fromJson(x))),
    similarVideos: json["similarVideos"] == null ? [] : List<SimilarVideo>.from(json["similarVideos"]!.map((x) => SimilarVideo.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );


}

class Pagination {
  final int? totalItems;
  final int? totalPages;
  final int? currentPage;
  final int? limit;

  Pagination({
    this.totalItems,
    this.totalPages,
    this.currentPage,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalItems: json["totalItems"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "limit": limit,
  };
}

class SimilarVideo {
  final String? id;
  final String? title;
  final String? contentType;
  final String? size;
  final String? countryName;
  final String? fabric;
  final String? material;
  final String? care;
  final String? occassionCategory;
  final String? gender;
  final String? description;
  final String? video;
  final String? videoPath;
  final int? popularity;
  final String? userId;
  final double? duration;
  final String? tiktok;
  final String? instragram;
  final int? likes;
  final double? ratings;
  final int? view;
  final String? thumbnail;
  final String? thumbnailPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isCurrentVideo;

  SimilarVideo({
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
    this.tiktok,
    this.instragram,
    this.likes,
    this.ratings,
    this.view,
    this.thumbnail,
    this.thumbnailPath,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isCurrentVideo,
  });

  factory SimilarVideo.fromJson(Map<String, dynamic> json) => SimilarVideo(
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
    tiktok: json["tiktok"],
    instragram: json["instragram"],
    likes: json["likes"],
    ratings: json["ratings"].runtimeType==int?json["ratings"].toDouble():json["ratings"],
    view: json["view"],
    thumbnail: json["thumbnail"],
    thumbnailPath: json["thumbnailPath"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isCurrentVideo: json["isCurrentVideo"],
  );

}

class Video {
  final String? id;
  final String? title;
  final String? contentType;
  final String? size;
  final String? countryName;
  final String? fabric;
  final String? material;
  final String? care;
  final String? occassionCategory;
  final String? gender;
  final String? description;
  final String? video;
  final String? videoPath;
  final int? popularity;
  final UserId? userId;
  final double? duration;
  final String tiktok;
  final String instragram;
  final int? likes;
  final double? ratings;
  final int? view;
  final String? thumbnail;
  final String? thumbnailPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? isLiked;

  Video({
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
    required this.tiktok,
    required this.instragram,
    this.likes,
    this.ratings,
    this.view,
    this.thumbnail,
    this.thumbnailPath,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isLiked,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    duration: json["duration"]?.toDouble(),
    tiktok: json["tiktok"]??"",
    instragram: json["instragram"]??"",
    likes: json["likes"],
    ratings:json["ratings"].runtimeType==int?json["ratings"].toDouble():json["ratings"],
    view: json["view"],
    thumbnail: json["thumbnail"],
    thumbnailPath: json["thumbnailPath"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isLiked: json["isLiked"],
  );

}

class UserId {
  final String? id;
  final String? fullName;
  final Image? image;

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
  final String? publicFileUrl;
  final String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

}



class Reviews {
  String? id;
  String? videoId;
  double? ratings;
  String? message;
  UserId? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Reviews({
    this.id,
    this.videoId,
    this.ratings,
    this.message,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    id: json["_id"],
    videoId: json["videoId"],
    ratings: json["ratings"].runtimeType==int?json["ratings"].toDouble():json["ratings"],
    message: json["message"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );


}

