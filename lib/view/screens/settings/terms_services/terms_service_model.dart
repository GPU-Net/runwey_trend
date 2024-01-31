
class TermsServiceModel {
  int? status;
  String? message;
  Data? data;

  TermsServiceModel({
    this.status,
    this.message,
    this.data,
  });

  factory TermsServiceModel.fromJson(Map<String, dynamic> json) => TermsServiceModel(
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
  String? termAndCondition;
  int? v;

  Data({
    this.id,
    this.termAndCondition,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    termAndCondition: json["termAndCondition"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "termAndCondition": termAndCondition,
    "__v": v,
  };
}
