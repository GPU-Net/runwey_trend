
class ChatModel {
  String? id;
  String? chat;
  String? message;
  Sender? sender;
  DateTime? createdAt;
  DateTime? updatedAt;

  ChatModel({
    this.id,
    this.chat,
    this.message,
    this.sender,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json["_id"],
    chat: json["chat"],
    message: json["message"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chat": chat,
    "message": message,
    "sender": sender?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Sender {
  String? id;
  String? fullName;
  Image? image;

  Sender({
    this.id,
    this.fullName,
    this.image,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    fullName: json["fullName"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "image": image?.toJson(),
  };
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
