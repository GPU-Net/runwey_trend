// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class ProfileModel {
  String? id;
  String? fullName;
  DateTime? dateOfBirth;
  String? gender;
  String? email;
  String? role;
  String? phoneNumber;
  String? countryCode;
  String? subcriptionType;
  Image? image;

  ProfileModel({
    this.id,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.email,
    this.role,
    this.phoneNumber,
    this.image,
    this.countryCode,
    this.subcriptionType
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["_id"],
        fullName: json["fullName"],
        // dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        dateOfBirth: json['dateOfBirth'] != null
        ? DateFormat('yyyy/MM/dd').parse(json['dateOfBirth'])
        : null,
        email: json["email"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        subcriptionType: json["subcriptionType"],
        countryCode: json["countryCode"],
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

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}