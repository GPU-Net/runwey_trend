// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  int? status;
  String? message;
  Data? data;

  BannerModel({
    this.status,
    this.message,
    this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<BannersDatum>? bannersData;

  Data({
    this.bannersData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannersData: json["bannersData"] == null ? [] : List<BannersDatum>.from(json["bannersData"]!.map((x) => BannersDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bannersData": bannersData == null ? [] : List<dynamic>.from(bannersData!.map((x) => x.toJson())),
  };
}

class BannersDatum {
  String? id;
  String? bannerImage;
  String? bannerName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BannersDatum({
    this.id,
    this.bannerImage,
    this.bannerName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BannersDatum.fromJson(Map<String, dynamic> json) => BannersDatum(
    id: json["_id"],
    bannerImage: json["bannerImage"],
    bannerName: json["bannerName"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerImage": bannerImage,
    "bannerName": bannerName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
