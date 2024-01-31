
class MySubscriptionModel {
  String? status;
  int? statusCode;
  Data? data;

  MySubscriptionModel({
    this.status,
    this.statusCode,
    this.data,
  });

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) => MySubscriptionModel(
    status: json["status"],
    statusCode: json["statusCode"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "data": data?.toJson(),
  };
}

class Data {
  String? type;
  Attributes? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  String? id;
  //String? userId;
  SubscriptionId? subscriptionId;
  DateTime? expiryDate;
  String? subscriptionType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attributes({
    this.id,
   // this.userId,
    this.subscriptionId,
    this.expiryDate,
    this.subscriptionType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    id: json["_id"],
    // userId: json["userId"],
    subscriptionId: json["subscriptionId"] == null ? null : SubscriptionId.fromJson(json["subscriptionId"]),
    expiryDate: json["expiryDate"] == null ? null : DateTime.parse(json["expiryDate"]),
    subscriptionType: json["subscriptionType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    //"userId": userId,
    "subscriptionId": subscriptionId?.toJson(),
    "expiryDate": expiryDate?.toIso8601String(),
    "subscriptionType": subscriptionType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class SubscriptionId {
  String? id;
  String? name;
  double? price;
  int? validity;
  int? limitation;
  String? mainColor;
  String? opacity1;
  String? opacity2;
  String? opacity3;
  String? type;
  bool? disable;
  int? v;

  SubscriptionId({
    this.id,
    this.name,
    this.price,
    this.validity,
    this.limitation,
    this.mainColor,
    this.opacity1,
    this.opacity2,
    this.opacity3,
    this.type,
    this.disable,
    this.v,
  });

  factory SubscriptionId.fromJson(Map<String, dynamic> json) => SubscriptionId(
    id: json["_id"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    validity: json["validity"],
    limitation: json["limitation"],
    mainColor: json["mainColor"],
    opacity1: json["opacity1"],
    opacity2: json["opacity2"],
    opacity3: json["opacity3"],
    type: json["type"],
    disable: json["disable"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "validity": validity,
    "limitation": limitation,
    "mainColor": mainColor,
    "opacity1": opacity1,
    "opacity2": opacity2,
    "opacity3": opacity3,
    "type": type,
    "disable": disable,
    "__v": v,
  };
}
