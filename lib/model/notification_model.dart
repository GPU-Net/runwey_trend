

class NotificationModel {
  String? id;
  String? message;
  String? imageLink;
  String? role;
  String? type;
  bool? viewStatus;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? receiverId;

  NotificationModel({
    this.id,
    this.message,
    this.imageLink,
    this.role,
    this.type,
    this.viewStatus,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.receiverId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["_id"],
    message: json["message"],
    imageLink: json["imageLink"],
    role: json["role"],
    type: json["type"],
    viewStatus: json["viewStatus"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    receiverId: json["receiverId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "message": message,
    "imageLink": imageLink,
    "role": role,
    "type": type,
    "viewStatus": viewStatus,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "receiverId": receiverId,
  };
}
