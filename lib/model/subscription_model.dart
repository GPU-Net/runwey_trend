

class SubscriptionModel {
  String? name;
  Package package;

  SubscriptionModel({
    this.name,
  required  this.package,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
        name: json["name"],
        package:Package.fromJson(json["package"]),
      );
}

class Package {
  String id;
  String? name;
  double? price;
  int? validity;
  int? limitation;
  String mainColor;
  String opacity1;
  String opacity2;
  String opacity3;

  Package({
    required this.id,
    this.name,
    this.price,
    this.validity,
    this.limitation,
   required this.mainColor,
    required  this.opacity1,
    required this.opacity2,
    required this.opacity3,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json['_id'],
        name: json["name"],
        price: json["price"].runtimeType==int?json["price"].toDouble():json["price"],
        validity: json["validity"],
        limitation: json["limitation"],
        mainColor: json["mainColor"],
        opacity1: json["opacity1"],
        opacity2: json["opacity2"],
        opacity3: json["opacity3"],
      );
}
