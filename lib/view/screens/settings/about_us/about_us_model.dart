
class AboutUsModel {
  int? status;
  String? message;
  Data? data;

  AboutUsModel({
    this.status,
    this.message,
    this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
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
  String? id;
  String? aboutUs;
  int? v;

  Data({
    this.id,
    this.aboutUs,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    aboutUs: json["aboutUs"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "aboutUs": aboutUs,
    "__v": v,
  };
}
