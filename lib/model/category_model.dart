
// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));


class CategoryModel {
  String? id;
  String? name;
  String? slug;
  String? categoryImage;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.categoryImage
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    categoryImage: json['categoryImage']
  );

}
